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
    uint256 defaultWhaleBalance = 1000000000 ether;
    address public daiWhale = makeAddr("USDC Whale");
    address public daiReceiver = makeAddr("USDC receiver");

    uint256 daiDecimals = 18;

    /// @dev Setup the testing environment.
    function setUp() public {
        string memory name = "USD coin";
        string memory symbol = "USDC";
        dai = IERC20(HuffDeployer.deploy("token/ERC20/ERC20"));
        daiOwner = dai.owner();

        vm.prank(daiOwner);
        dai.mint(daiWhale, defaultWhaleBalance);
    }

    function testMint() public returns (uint256 mintedAmount){
        mintedAmount = 1000 ether;

        vm.startPrank(daiOwner);

        uint256 oldBalance = dai.balanceOf(daiOwner);

        dai.mint(daiOwner, mintedAmount);
        uint256 newBalance = dai.balanceOf(daiOwner);
        
        assertEq(newBalance, oldBalance+mintedAmount);
        
        vm.stopPrank();
    }

    function testTotalSupply() public {
        uint256 expectedSupply = testMint() + defaultWhaleBalance;
        uint256 supply = dai.totalSupply();
        assertEq(supply, expectedSupply);
    }

    function testBalanceOf() public {
        uint256 oldBalance = dai.balanceOf(daiOwner);
        assertEq(oldBalance, 0);

        uint256 mintedAmount = testMint();

        assertEq(dai.balanceOf(daiOwner), mintedAmount);

        mintedAmount = testMint();

        assertEq(dai.balanceOf(daiOwner), mintedAmount*2);
    }

    function testTransfer() public {
        assertEq(dai.balanceOf(daiWhale), defaultWhaleBalance);

        uint256 oldSenderBalance = dai.balanceOf(daiWhale);
        uint256 oldReceiverBalance = dai.balanceOf(daiReceiver);
        uint256 sendValue = 100 ether;
        
        vm.prank(daiWhale);
        dai.transfer(daiReceiver, sendValue);

        assertEq(dai.balanceOf(daiReceiver), oldReceiverBalance + sendValue);
        assertEq(dai.balanceOf(daiWhale), oldSenderBalance - sendValue);
    }

    function testTransferFrom() public {
        assertEq(dai.balanceOf(daiWhale), defaultWhaleBalance);

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

        dai.approve(address(this), type(uint256).max);
        assertEq(dai.allowance(daiWhale, address(this)), type(uint256).max);

        dai.approve(address(this), 0);
        assertEq(dai.allowance(daiWhale, address(this)), 0);
        
        vm.stopPrank();
    }

    function testDecimals() public {
        assertEq(dai.decimals(), 18);
    }
}