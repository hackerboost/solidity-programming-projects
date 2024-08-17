const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("CryptoDevsModule", (m) => {
    // Replace with your deployed Whitelist contract address
    const whitelistContractAddress = "0xAA2740a92bc36F88b2da3Fd2CF5898b26dd10639";

    // Deploy the CryptoDevs contract with the specified whitelist contract address
    const cryptoDevs = m.contract("CryptoDevs", [whitelistContractAddress]);

    return { cryptoDevs };
});
