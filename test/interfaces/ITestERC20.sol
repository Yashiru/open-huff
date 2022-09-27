// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

interface ITestERC20 {
	event Approval(address, address, uint256);
	event Transfer(address, address, uint256);

	error AmountExceedsBalance();
	error CallerIsNotTheOwner();
	error InsufficientAllowance();
	error TransferToZeroAddress();
}