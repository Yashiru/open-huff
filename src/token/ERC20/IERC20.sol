interface IERC20 {
	event Approval(address, address, uint256);
	event Transfer(address, address, uint256);
	function allowance(address, address) external view returns (uint256);
	function approve(address, uint256) external returns (bool);
	function balanceOf(address) external view returns (uint256);
	function decimals() external view returns (uint256);
	function decreaseAllowance(address, uint256) external;
	function increaseAllowance(address, uint256) external;
	function name() external view returns (string memory);
	function owner() external view returns (address);
	function symbol() external view returns (string memory);
	function totalSupply() external view returns (uint256);
	function transfer(address, uint256) external;
	function transferFrom(address, address, uint256) external;
}