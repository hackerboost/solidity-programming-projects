const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

module.exports = buildModule("LotteryModule", (m) => {

    // Deploy the RandomWinnerGame contract
    const lottery = m.contract("Lottery");

    return { lottery };
});