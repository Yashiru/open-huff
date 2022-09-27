// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "test/Constants.sol";

import {IERC20} from "../../../src/token/ERC20/IERC20.sol";
import {ITestERC20} from "../../interfaces/ITestERC20.sol";

contract ERC20 is Test, ITestERC20 {
    /// @dev Address of the SimpleStore contract.  
    IERC20 public dai;
    address public daiOwner;

    /// @dev Setup the testing environment.
    function setUp() public {
        dai = IERC20(HuffDeployer.deploy_with_args(
            "token/ERC20/ERC20", 
            abi.encode(
                ERC20_NAME,
                ERC20_SYMBOL,
                ERC20_SUPPLY
            )
        ));
        daiOwner = dai.owner();
        
        vm.prank(daiOwner);
        dai.transfer(DAI_WHALE, 1000000 ether);
    }

    function testTotalSupply() public {
        uint256 expectedSupply = ERC20_SUPPLY;
        uint256 supply = dai.totalSupply();
        assertEq(supply, expectedSupply);
    }

    function testBalanceOf() public {
        assertEq(dai.balanceOf(daiOwner), ERC20_SUPPLY - dai.balanceOf(DAI_WHALE));
        assertEq(dai.balanceOf(EMPTY_DAI_WALLET), 0);
    }

    function testTransfer() public {
        assertEq(dai.balanceOf(daiOwner), ERC20_SUPPLY - dai.balanceOf(DAI_WHALE));

        uint256 oldSenderBalance = dai.balanceOf(DAI_WHALE);
        uint256 oldReceiverBalance = dai.balanceOf(DAI_RECEIVER);
        uint256 sendValue = 100 ether;
        
        vm.startPrank(DAI_WHALE);

        dai.transfer(DAI_RECEIVER, sendValue);

        assertEq(dai.balanceOf(DAI_RECEIVER), oldReceiverBalance + sendValue);
        assertEq(dai.balanceOf(DAI_WHALE), oldSenderBalance - sendValue);

        // Test can't send fund to address(0)
        vm.expectRevert(TransferToZeroAddress.selector);
        dai.transfer(address(0), 10);

        vm.stopPrank();

        // Test transfer more than balance
        vm.expectRevert(AmountExceedsBalance.selector);
        dai.transfer(DAI_RECEIVER, 10);
    }

    function testTransfesrFrom() public {
        assertEq(dai.balanceOf(daiOwner), ERC20_SUPPLY - dai.balanceOf(DAI_WHALE));

        uint256 oldSenderBalance = dai.balanceOf(DAI_WHALE);
        uint256 oldReceiverBalance = dai.balanceOf(DAI_RECEIVER);
        uint256 sendValue = 100 ether;
        
        vm.prank(DAI_WHALE);
        dai.approve(address(this), type(uint256).max);

        dai.transferFrom(DAI_WHALE, DAI_RECEIVER, sendValue);

        assertEq(dai.balanceOf(DAI_RECEIVER), oldReceiverBalance + sendValue);
        assertEq(dai.balanceOf(DAI_WHALE), oldSenderBalance - sendValue);

        // Test can't send fund to address(0)
        vm.expectRevert(TransferToZeroAddress.selector);
        dai.transferFrom(DAI_WHALE, address(0), 10);

        // Test can't send fund from address(0)
        vm.expectRevert(InsufficientAllowance.selector);
        dai.transferFrom(address(0), DAI_WHALE, 10);
    }

    function testApprove() public {
        vm.startPrank(DAI_WHALE);

        dai.approve(address(this), 1);
        assertEq(dai.allowance(DAI_WHALE, address(this)), 1);

        dai.approve(address(this), 0);
        assertEq(dai.allowance(DAI_WHALE, address(this)), 0);
        
        vm.stopPrank();
    }

    function testIncreaseAllowance() public {
        vm.startPrank(DAI_WHALE);

        dai.approve(address(this), 1);
        assertEq(dai.allowance(DAI_WHALE, address(this)), 1);
        
        dai.increaseAllowance(address(this), 1);
        assertEq(dai.allowance(DAI_WHALE, address(this)), 2);

        vm.stopPrank();
    }

    function testDecreaseAllowance() public {
        vm.startPrank(DAI_WHALE);

        dai.approve(address(this), 2);
        assertEq(dai.allowance(DAI_WHALE, address(this)), 2);

        dai.decreaseAllowance(address(this), 1);
        assertEq(dai.allowance(DAI_WHALE, address(this)), 1);
        
        vm.stopPrank();
    }

    function testDecimals() public {
        assertEq(dai.decimals(), 18);
    }

    function testName() public {
        assertEq(dai.name(), ERC20_NAME);
    }

    function testSymbol() public {
        assertEq(dai.symbol(), ERC20_SYMBOL);
    }
}