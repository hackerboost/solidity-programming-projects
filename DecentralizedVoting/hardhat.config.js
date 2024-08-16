require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.24",
  networks: {
      arbitrumSepolia: {
          url: process.env.ALCHEMY_URL,
          accounts: [`0x${process.env.PRIVATE_KEY}`]
      }
  }
};
