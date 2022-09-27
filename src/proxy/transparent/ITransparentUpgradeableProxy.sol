interface ITransparentUpgradeableProxy {
	event AdminChanged(address, address);
	event BeaconUpgraded(address);
	event Upgraded(address);
	error BeaconImplementationIsNotAContract();
	error NewAdminAddressIsZeroAddress();
	error NewBeaconIsNotAContract();
	error NewImplementationIsNotAContract();
	function admin() external returns (address);
	function changeAdmin(address) external;
	function implementation() external returns (address);
	function upgradeTo(address) external;
	function upgradeToAndCall(address, bytes memory) external;
}