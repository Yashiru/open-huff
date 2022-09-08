// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.16;

import "foundry-huff/HuffDeployer.sol";
import "forge-std/Script.sol";

import {IAddition} from "../src/interfaces/IAddition.sol";

contract Deploy is Script {
  function run() public returns (IAddition addition) {
    addition = IAddition(HuffDeployer.deploy("Addition"));
  }
}
