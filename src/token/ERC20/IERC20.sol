interface IERC20 {
	event Approve(address, address, uint256);
	event Transfer(address, address, uint256);
	function allowance(address, address) external view returns (uint256);
	function approve(address, uint256) external;
	function balanceOf(address) external view returns (uint256);
	function mint(address, uint256) external;
	function owner() external view returns (address);
	function totalSupply() external view returns (uint256);
	function transfer(address, uint256) external;
	function transferFrom(address, address, uint256) external;
}