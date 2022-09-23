// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {IERC20} from "../src/token/ERC20/IERC20.sol";

contract ERC20 is Test {
    /// @dev Address of the SimpleStore contract.  
    IERC20 public dai;
    address public daiOwner;
    address public daiWhale = makeAddr("DAI Whale");
    address public daiReceiver = makeAddr("DAI receiver");
    address public emptyDaiWallet = makeAddr("empty");
    uint256 public supply = 1000000000 ether;

    string constant name = "Dai Stablecoin";
    string constant symbol = "DAI";

    uint256 daiDecimals = 18;

    /// @dev Setup the testing environment.
    function setUp() public {
        dai = IERC20(HuffDeployer.deploy_with_args(
            "token/ERC20/ERC20", 
            abi.encode(
                name,
                symbol,
                supply
            )
        ));
        daiOwner = dai.owner();
        
        vm.prank(daiOwner);
        dai.transfer(daiWhale, 1000000 ether);
    }

    function testTotalSupply() public {
        uint256 expectedSupply = supply;
        uint256 supply = dai.totalSupply();
        assertEq(supply, expectedSupply);
    }

    function testBalanceOf() public {
        assertEq(dai.balanceOf(daiOwner), supply - dai.balanceOf(daiWhale));
        assertEq(dai.balanceOf(emptyDaiWallet), 0);
    }

    function testTransfer() public {
        assertEq(dai.balanceOf(daiOwner), supply - dai.balanceOf(daiWhale));

        uint256 oldSenderBalance = dai.balanceOf(daiWhale);
        uint256 oldReceiverBalance = dai.balanceOf(daiReceiver);
        uint256 sendValue = 100 ether;
        
        vm.prank(daiWhale);
        dai.transfer(daiReceiver, sendValue);

        assertEq(dai.balanceOf(daiReceiver), oldReceiverBalance + sendValue);
        assertEq(dai.balanceOf(daiWhale), oldSenderBalance - sendValue);
    }

    function testTransferFrom() public {
        assertEq(dai.balanceOf(daiOwner), supply - dai.balanceOf(daiWhale));

        uint256 oldSenderBalance = dai.balanceOf(daiWhale);
        uint256 oldReceiverBalance = dai.balanceOf(daiReceiver);
        uint256 sendValue = 100 ether;
        
        vm.prank(daiWhale);
        dai.approve(address(this), type(uint256).max);

        dai.transferFrom(daiWhale, daiReceiver, sendValue);

        assertEq(dai.balanceOf(daiReceiver), oldReceiverBalance + sendValue);
        assertEq(dai.balanceOf(daiWhale), oldSenderBalance - sendValue);
    }

    function testApprove() public {
        vm.startPrank(daiWhale);

        dai.approve(address(this), 1);
        assertEq(dai.allowance(daiWhale, address(this)), 1);

        dai.approve(address(this), 0);
        assertEq(dai.allowance(daiWhale, address(this)), 0);
        
        vm.stopPrank();
    }

    function testIncreaseAllowance() public {
        vm.startPrank(daiWhale);

        dai.approve(address(this), 1);
        assertEq(dai.allowance(daiWhale, address(this)), 1);
        
        dai.increaseAllowance(address(this), 1);
        assertEq(dai.allowance(daiWhale, address(this)), 2);

        vm.stopPrank();
    }

    function testDecreaseAllowance() public {
        vm.startPrank(daiWhale);

        dai.approve(address(this), 2);
        assertEq(dai.allowance(daiWhale, address(this)), 2);

        dai.decreaseAllowance(address(this), 1);
        assertEq(dai.allowance(daiWhale, address(this)), 1);
        
        vm.stopPrank();
    }

    function testDecimals() public {
        assertEq(dai.decimals(), 18);
    }

    function testName() public {
        assertEq(dai.name(), name);
    }

    function testSymbol() public {
        assertEq(dai.symbol(), symbol);
    }
}