// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";

import {IAddition} from "../src/interfaces/IAddition.sol";

contract SimpleStoreTest is Test {
    /// @dev Address of the SimpleStore contract.  
    IAddition public additions;

    /// @dev Setup the testing environment.
    function setUp() public {
        additions = IAddition(HuffDeployer.deploy("Additions"));
    }

    function testAdditions() public {
        uint256 result = additions.addTwo(4, 5);
        assertEq(result, 9);

        result = additions.addThree(4, 5, 11);
        assertEq(result, 20);
    }
}