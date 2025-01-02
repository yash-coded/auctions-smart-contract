import { config as envConfig } from "dotenv";
envConfig();
import { HardhatUserConfig } from "hardhat/config";
import "@nomicfoundation/hardhat-toolbox";

const config: HardhatUserConfig = {
  solidity: "0.8.28",
  networks: {
    localhost: {
      url: "http://localhost:8545",
      accounts: [`${process.env.PRIVATE_KEY}`],
    },
    sepolia: {
      url: "https://sepolia.gateway.tenderly.co",
      accounts: [`${process.env.PRIVATE_KEY}`],
    },
  },
};

export default config;
