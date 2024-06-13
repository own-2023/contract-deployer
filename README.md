

This repository is created for deploying, compiling, and testing smart contracts using Truffle project.

# ImageNFT Smart Contract

This is a smart contract for a non-fungible token (NFT) based on the ERC-721 standard. It allows users to create NFTs with image URLs and to buy/sell them using ETH

# Requirements

    Node.js version 18 or higher, Truffle
    Windows, Linux, or macOS

# Usage

This command installs the project dependencies.

```bash
npm install truffle -g
npm install
```

Compile the smart contract

```bash
truffle compile
```

Deploy the smart contract.

```bash
truffle migrate
```


⚠️ This will deploy the smart contract to a local development network (e.g., Ganache). If you want to deploy to a different network, modify the truffle-config.js file accordingly.
