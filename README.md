# <img src="./assets/logo.png" alt="Open Huff" height="60px">
[![doc](https://img.shields.io/badge/docs-here-blue)](https://docs.openhuff.com/) ![license](https://img.shields.io/github/license/Yashiru/open-huff.svg) ![coverage](https://img.shields.io/badge/coverage-0-red) ![solidity](https://img.shields.io/badge/solidity-^0.8.16-lightgrey)

A library for secure [Huff](https://github.com/huff-language/huff-rs) smart contract development. Directly inspired by [OpenZeppelin contracts](https://github.com/OpenZeppelin/openzeppelin-contracts), this library is an implementation of the openzeppelin's concepts, written in [Huff](https://github.com/huff-language/huff-rs) and thus much more economic in terms of gas usage.

> This library is under development and you won't find all the openzeppelin designs yet.

## Overview

### Installation 
```bash
git submodule add https://github.com/Yashiru/open-huff
```

## Usage
Once installed, you can use the contracts in the library by importing them:
```huff
#include "@open-huff/contracts/ERC20.sol"
```

## Security
This project is maintained by [Yashiru](https://github.com/Yashiru). Open Huff Contracts is meant to provide tested and community-audited code, but please use common sense when doing anything that deals with real money! We take no responsibility for your implementation decisions and any security problems you might experience.

> ⚠️ No audit has been done yet. ⚠️

## Contribute
Open Huff Contracts exists thanks to its contributors. There are many ways you can participate and help build high quality software. Check out the [issues panel](https://github.com/Yashiru/open-huff/issues).

### Requirements

The following will need to be installed in order to work on this project. Please follow the links and instructions.

-   [Foundry / Foundryup](https://github.com/gakonst/foundry)
    -   This will install `forge`, `cast`, and `anvil`
    -   To get the latest of each, just run `foundryup`
-   [Huff Compiler](https://docs.huff.sh/get-started/installing/)
    -   You'll know you've done it right if you can run `huffc --version` and get an output like: `huffc 0.3.0`

### Quickstart

1. Install dependencies

Once you've cloned and entered into your repository, you need to install the necessary dependencies. In order to do so, simply run:

```bash
forge install
```

2. Build & Test

To build and test your contracts with [foundry](https://github.com/gakonst/foundry), you can run:

```bash
forge build
forge test # To simply run tests
forge test -vvv # To run tests and print execution traces of failing tests
```

To compile your contract using Huff, you can run:

```bash
huffc ./path/to/your/contract.huff
```

For more information on how to use Foundry, check out the [Foundry Github Repository](https://github.com/foundry-rs/foundry/tree/master/forge) and the [foundry-huff library repository](https://github.com/huff-language/foundry-huff).

For mor information on how to use Huff, check out the [Huff documentation](https://docs.huff.sh/) and the [Huff language repository](https://github.com/huff-language/huff-rs).

## License
Open Huff Contracts is released under the MIT License.
