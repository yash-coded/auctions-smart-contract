import { config } from "dotenv";
config();

import { ethers } from "hardhat";

async function main() {
  const [deployer] = await ethers.getSigners();
  console.log("Deploying contracts with the account:", deployer.address);

  const Auction = await ethers.getContractFactory("AuctionManager");

  const auction = await Auction.deploy();

  console.log("Auction deployed to:", await auction.getAddress());
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
