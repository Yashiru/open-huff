// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

interface ITestTransparentUpgradeableProxy {
	event AdminChanged(address, address);
	event BeaconUpgraded(address);
	event Upgraded(address);
	
	error BeaconImplementationIsNotAContract();
	error NewImplementationIsNotAContract();
	error NewAdminAddressIsZeroAddress();
	error NewBeaconIsNotAContract();
}