// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {IERC20} from "../src/token/ERC20/IERC20.sol";

contract ERC20 is Test {
    /// @dev Address of the SimpleStore contract.  
    IERC20 public erc20;

    /// @dev Setup the testing environment.
    function setUp() public {
        erc20 = IERC20(HuffDeployer.deploy("token/ERC20/ERC20"));
    }

    function testInitial() public {
        uint256 totalSupply = erc20.totalSupply();
        uint256 balanceOf = erc20.balanceOf(address(0));
        bool transfer = erc20.transfer(address(0), 0);
        uint256 allowance = erc20.allowance(address(0), address(0));
        bool approve = erc20.approve(address(0), 0);
        bool transferFrom = erc20.transferFrom(address(0), address(0), 0);

        console.log(totalSupply);
        console.log(balanceOf);
        console.logBool(transfer);
        console.log(allowance);
        console.logBool(approve);
        console.logBool(transferFrom);
    }
}