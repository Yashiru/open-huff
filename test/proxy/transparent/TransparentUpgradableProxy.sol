// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Test.sol";
import "forge-std/console.sol";
import "test/Constants.sol";

import {IERC20} from "../../../src/token/ERC20/IERC20.sol";
import {ITransparentUpgradeableProxy} from "../../../src/proxy/transparent/ITransparentUpgradeableProxy.sol";

contract ERC20 is Test {
    ITransparentUpgradeableProxy proxy;
    IERC20 implementation;
    IERC20 secondImplementation;

    /// @dev Setup the testing environment.
    function setUp() public {
        implementation = IERC20(HuffDeployer.deploy_with_args(
            "token/ERC20/ERC20", 
            abi.encode(
                ERC20_NAME,
                ERC20_SYMBOL,
                ERC20_SUPPLY
            )
        ));
        secondImplementation = IERC20(HuffDeployer.deploy_with_args(
            "token/ERC20/ERC20", 
            abi.encode(
                ERC20_NAME,
                ERC20_SYMBOL,
                ERC20_SUPPLY
            )
        ));
        proxy = ITransparentUpgradeableProxy(HuffDeployer.deploy_with_args(
            "proxy/transparent/TransparentUpgradeableProxy", 
            abi.encode(
                implementation,
                PROXY_ADMIN
            )
        ));
    }

    function testAdmin() public {
        vm.startPrank(PROXY_ADMIN);

        address admin = proxy.admin();
        assertEq(admin, PROXY_ADMIN);

        vm.stopPrank();
    }

    function testImplementation() public {
        vm.startPrank(PROXY_ADMIN);

        address imp = proxy.implementation();
        assertEq(imp, address(implementation));

        vm.stopPrank();
    }

    function testChangeAdmin() public {
        vm.startPrank(PROXY_ADMIN);

        address expectedNewAdmin = makeAddr("new admin");
        proxy.changeAdmin(address(expectedNewAdmin));

        vm.stopPrank();
        vm.startPrank(address(expectedNewAdmin));

        address newAdmin = proxy.admin();
        assertEq(newAdmin, expectedNewAdmin);

        vm.stopPrank();
    }

    function testUpgradeTo() public {
        vm.startPrank(PROXY_ADMIN);

        proxy.upgradeTo(address(secondImplementation));

        address newImp = proxy.implementation();
        assertEq(newImp, address(secondImplementation));

        vm.stopPrank();
    }

    function testUpgradeToAndCall() public {
        vm.startPrank(PROXY_ADMIN);
        
        (bool success, bytes memory data) = address(proxy).call(
            abi.encodeWithSignature(
                "upgradeToAndCall(address,bytes)",
                address(implementation), 
                abi.encodeWithSignature("name()")
            )
        );

        address newImp = proxy.implementation();
        assertEq(newImp, address(implementation));
        assertTrue(success);

        vm.stopPrank();
    }

    function testNonAdminCall() public {
        (bool success, bytes memory data) = address(proxy).call(
            abi.encodeWithSignature(
                "decimals()"
            )
        );

        assertTrue(success);
        assertEq(uint256(bytes32(data)), uint256(0x12));
    }
}