// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "test/Constants.sol";

import {IAccessControl} from "../../src/access/IAccessControl.sol";
import {ITestAccessControl} from "../interfaces/ITestAccessControl.sol";

contract AccessControl is Test, ITestAccessControl {
    /// @dev Address of the SimpleStore contract.  
    IAccessControl public accessControl;

    /// @dev Setup the testing environment.
    function setUp() public {
        accessControl = IAccessControl(HuffDeployer.deploy(
            "access/AccessControl"
        ));
    }

    function testAccess() public {
        accessControl.test();
    }
}