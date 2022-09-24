// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

// ERC20 test constants
address constant DAI_WHALE = address(0x3b505aF97031B75e2be39e7F8FA1fA634857F29a);
address constant DAI_RECEIVER = address(0x3b505af97031B75e2BE39e7F8fa1FA634857f29B);
address constant EMPTY_DAI_WALLET = address(0x3B505aF97031B75e2bE39E7f8fA1fA634857F29c);
uint256 constant ERC20_SUPPLY = 1000000000 ether;
string constant ERC20_NAME = "Dai Stablecoin";
string constant ERC20_SYMBOL = "DAI";
uint256 constant DAI_DECIMALS = 18;

// TransparentUpgradeableProx constants
address constant PROXY_ADMIN = address(0x3b505af97031B75E2BE39e7f8FA1Fa634857f29F);