interface IAccessControl {
	error CallerDoesNotHaveRequiredRole();
	function test() external;
}