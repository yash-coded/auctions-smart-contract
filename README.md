# Auctions Smart Contract Project

This project demonstrates a decentralized auction platform built using Solidity, Hardhat, and ethers.js. The platform allows users to create auctions, place bids, and manage the auction lifecycle. The frontend is built using Next.js and integrates with MetaMask for Ethereum transactions.

## Features

- **Create Auctions**: Users can create new auctions by specifying item details, starting bid, and auction duration.
- **Place Bids**: Users can place bids on active auctions. The highest bid is tracked, and previous highest bidders are refunded.
- **End Auctions**: Auctions automatically end after the specified duration, and the highest bid amount is transferred to the seller.
- **View Auctions**: Users can view all auctions, active auctions, and auctions created by a specific seller.

## Technologies Used

- **Solidity**: Smart contract development language.
- **Hardhat**: Ethereum development environment for compiling, deploying, and testing smart contracts.
- **ethers.js**: Library for interacting with the Ethereum blockchain.
- **Next.js**: React framework for building the frontend.
- **MetaMask**: Browser extension for managing Ethereum accounts and transactions.
- **TypeScript**: Typed superset of JavaScript for type safety and better developer experience.
- **dotenv**: Module for loading environment variables from a `.env` file.

## Smart Contracts

### AuctionManager.sol

The `AuctionManager` contract manages the creation and lifecycle of auctions. It includes the following functions:

- `createAuction`: Creates a new auction with specified item details, starting bid, and duration.
- `placeBid`: Allows users to place bids on an active auction.
- `endAuction`: Ends an auction and transfers the highest bid amount to the seller.
- `getAuction`: Retrieves details of a specific auction.
- `getAllAuctions`: Retrieves all auctions.
- `getActiveAuctions`: Retrieves all active auctions.
- `getAuctionsBySeller`: Retrieves all auctions created by a specific seller.
- `getBids`: Retrieves bids for a specific auction.

### Deployment Script

The `deploy.ts` script deploys the `AuctionManager` contract to the specified network using Hardhat.

## Setup and Deployment

### Prerequisites

- Node.js
- MetaMask extension

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/auctions-smart-contract.git
   cd auctions-smart-contract
   ```
2. Install dependencies:
   ```bash
   npm install
   ```
3. Create a `.env` file in the project root and add the following environment variables:
   ```plaintext
    PRIVATE_KEY=yourprivatekey
   ```

### Compile and Deploy Contracts

1. Compile the contracts:
   ```bash
   npx hardhat compile
   ```
2. Deploy the contracts to the desired network (e.g., localhost):
   ```bash
    npx hardhat run scripts/deploy.ts --network localhost
   ```

## Skills Demonstrated

- Smart Contract Development: Proficient in writing and deploying Solidity smart contracts.
- Ethereum Development: Experience with Hardhat for Ethereum development and testing.
- Blockchain Integration: Integrating smart contracts with a React frontend using ethers.js and MetaMask.
- Full-Stack Development: Building a full-stack decentralized application with Next.js and TypeScript.
- Environment Management: Using dotenv for managing environment variables securely.

## License

This project is licensed under the MIT License.
