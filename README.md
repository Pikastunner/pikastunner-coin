# ERC-20 Compliant TokenExchange Smart Contract

## Introduction
The TokenExchange smart contract is an ERC-20 compliant contract deployed on the Ethereum blockchain. It facilitates the exchange of tokens and implements various features required by the ERC-20 standard.

## Features
- **Token Exchange**: Allows users to exchange tokens with each other.
- **ERC-20 Compliance**: Implements the necessary functions and events required by the ERC-20 token standard.
- **Upfront Payment**: Charges a fee (in tokens) for transactions, which is deducted from the sender's balance and credited to the contract owner.
- **Interest Charging**: Charges interest on loans made by users, which is deducted from the borrower's balance and credited to the contract owner.
- **Starting Capital**: Allows users to set an initial capital when opening an account.

## Deployment
The contract can be deployed using the provided deployment script. The contract constructor accepts the following parameters:
- `_name`: Name of the token.
- `_symbol`: Symbol of the token.
- `_decimals`: Number of decimal places for the token.
- `_initialSupply`: Initial supply of tokens.
- `_feePercentage`: Percentage fee charged for transactions.
- `_interestRates`: Percentage interest charged on loans.
- `_startCapital`: Initial capital for new accounts.

## Usage
Once deployed, users can interact with the contract using various functions such as `transfer`, `approve`, `transferFrom`, `chargeInterest`, and `startingCapital`. These functions enable token transfers, approvals, interest charging, and account setup.

## Testing
It's recommended to thoroughly test the contract functionality, including edge cases and scenarios involving multiple users, before deploying it on the main Ethereum network.

## Disclaimer
- Use this contract at your own risk. While efforts have been made to ensure its correctness and security, bugs and vulnerabilities may still exist.
- Ensure that you fully understand the contract's behavior and implications before deploying it or interacting with it on the blockchain.
