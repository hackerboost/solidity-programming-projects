const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("WhitelistModule", (m) => {
    // Set the maximum number of whitelisted addresses
    const maxWhitelistedAddresses = 10;

    // Deploy the Whitelist contract with the specified number of max whitelisted addresses
    const whitelist = m.contract("Whitelist", [maxWhitelistedAddresses]);

    return { whitelist };
});
