require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

const ALCHEMY_RPC_URL = vars.get("ALCHEMY_RPC_URL");
const ACCOUNT_PRIVATE_KEY = vars.get("ACCOUNT_PRIVATE_KEY");
const ETHERSCAN_API_KEY = vars.get("ETHERSCAN_API_KEY");

module.exports = {
    solidity: "0.8.24",
    networks: {
    sepolia: {
        url: process.env.ALCHEMY_RPC_URL,
        accounts: [`0x${process.env.ACCOUNT_PRIVATE_KEY}`]
    }
    },
    etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY
    }
};