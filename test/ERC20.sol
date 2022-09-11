// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {IERC20} from "../src/token/ERC20/IERC20.sol";

contract ERC20 is Test {
    /// @dev Address of the SimpleStore contract.  
    IERC20 public usdc;
    address public usdcOwner;
    uint256 defaultWhaleBalance = 1000000000 ether;
    address public usdcWhale = makeAddr("USDC Whale");
    address public usdcReceiver = makeAddr("USDC receiver");

    /// @dev Setup the testing environment.
    function setUp() public {
        string memory name = "USD coin";
        string memory symbol = "USDC";
        usdc = IERC20(HuffDeployer.deploy("token/ERC20/ERC20"));
        usdcOwner = usdc.owner();

        vm.prank(usdcOwner);
        usdc.mint(usdcWhale, defaultWhaleBalance);
    }

    function testMint() public returns (uint256 mintedAmount){
        mintedAmount = 1000 ether;

        vm.startPrank(usdcOwner);

        uint256 oldBalance = usdc.balanceOf(usdcOwner);

        usdc.mint(usdcOwner, mintedAmount);
        uint256 newBalance = usdc.balanceOf(usdcOwner);
        
        assertEq(newBalance, oldBalance+mintedAmount);
        
        vm.stopPrank();
    }

    function testTotalSupply() public {
        uint256 expectedSupply = testMint() + defaultWhaleBalance;
        uint256 supply = usdc.totalSupply();
        assertEq(supply, expectedSupply);
    }

    function testBalanceOf() public {
        uint256 oldBalance = usdc.balanceOf(usdcOwner);
        assertEq(oldBalance, 0);

        uint256 mintedAmount = testMint();

        assertEq(usdc.balanceOf(usdcOwner), mintedAmount);

        mintedAmount = testMint();

        assertEq(usdc.balanceOf(usdcOwner), mintedAmount*2);
    }

    function testTransfer() public {
        assertEq(usdc.balanceOf(usdcWhale), defaultWhaleBalance);

        uint256 oldSenderBalance = usdc.balanceOf(usdcWhale);
        uint256 oldReceiverBalance = usdc.balanceOf(usdcReceiver);
        uint256 sendValue = 100 ether;
        
        vm.prank(usdcWhale);
        usdc.transfer(usdcReceiver, sendValue);

        assertEq(usdc.balanceOf(usdcReceiver), oldReceiverBalance + sendValue);
        assertEq(usdc.balanceOf(usdcWhale), oldSenderBalance - sendValue);
    }

    function testTransferFrom() public {
        assertEq(usdc.balanceOf(usdcWhale), defaultWhaleBalance);

        uint256 oldSenderBalance = usdc.balanceOf(usdcWhale);
        uint256 oldReceiverBalance = usdc.balanceOf(usdcReceiver);
        uint256 sendValue = 100 ether;
        
        vm.prank(usdcWhale);
        usdc.approve(address(this), type(uint256).max);

        usdc.transferFrom(usdcWhale, usdcReceiver, sendValue);

        assertEq(usdc.balanceOf(usdcReceiver), oldReceiverBalance + sendValue);
        assertEq(usdc.balanceOf(usdcWhale), oldSenderBalance - sendValue);
    }

    function testApprove() public {
        vm.startPrank(usdcWhale);

        usdc.approve(address(this), type(uint256).max);
        assertEq(usdc.allowance(usdcWhale, address(this)), type(uint256).max);

        usdc.approve(address(this), 0);
        assertEq(usdc.allowance(usdcWhale, address(this)), 0);
        
        vm.stopPrank();
    }
}