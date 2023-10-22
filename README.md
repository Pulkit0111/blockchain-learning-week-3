# Blockchain Learning Week 3

# Decentralized Banking Platform Project

## Overview

This week 3 assignent aims to understand solidity in a deeper manner along with understnding of hardhat and how unit testing can help in testing sart contracts.

## Progress

### Assignment 17: Advanced ERC-20 Token Contract

- Created the "AdvancedToken" contract with features like token locking, minting, and burning.
- Used Solidity to implement the contract with appropriate events and modifiers.
- This contract serves as the basis for the decentralized banking platform.

### Assignment 18: Hardhat Deployment and Testing

- Deployed the "AdvancedToken" contract onto the Hardhat Network using a deployment script.
- Wrote unit tests to ensure that the contract's functionalities work as expected.
- Tested token minting, token burning, token locking, and other aspects of the contract.

### Assignment 19: Debugging Scenario

- Discovered a bug where users could burn tokens even if they were locked.
- Wrote a unit test to simulate this error and verified the issue.
- Debugged the contract to add a check for locked tokens in the "burnTokens" function.
- The bug was resolved by ensuring that only unlocked tokens could be burned.

### Assignment 20: DApp Conceptualization

- Designed the high-level structure of the decentralized banking platform.
- Identified primary smart contracts (AdvancedToken, DepositContract, LendingContract, BorrowingContract).
- Outlined their key functions and interactions.
- Provided a conceptual overview of how users can deposit, lend, and borrow on the platform.

## Challenges Encountered

- In Assignment 17, the initial challenge was implementing the ERC-20 token with added features like locking, minting, and burning. OpenZeppelin was not used, which required manual implementation and thorough testing.
- In Assignment 19, identifying the bug and debugging it required a deep understanding of the contract's logic and state variables.

## Insights Gained

- A deeper understanding of Solidity and smart contract development was gained through manual implementation of an ERC-20 token and debugging.
- Writing unit tests to verify contract functionality and identify issues is a crucial part of the development process.
- Designing a DApp requires careful consideration of the interactions between smart contracts and user workflows.