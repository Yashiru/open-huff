// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

interface IAddition {
    function addTwo(uint256, uint256) external returns (uint256);
    function addThree(uint256, uint256, uint256) external returns (uint256);
}