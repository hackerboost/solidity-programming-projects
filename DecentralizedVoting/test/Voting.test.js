const { expect } = require("chai");
const hre = require("hardhat");

describe("Voting Contract", function () {
    let voting;

    // This function runs before each test, setting up the contract instance.
    beforeEach(async function () {

        // Deploy the Voting contract and wait for it to be deployed.
        voting = await hre.ethers.deployContract("Voting");
    });

    // Test case: Should allow a proposal to be created.
    it("Should allow a proposal to be created", async function () {
        // Create a new proposal.
        await voting.createProposal("Proposal 1");

        // Retrieve the proposal details.
        const proposal = await voting.getProposal(0);

        // Verify that the proposal's name is correct.
        expect(proposal[0]).to.equal("Proposal 1");
    });

    // Test case: Should allow a user to vote and increment vote count.
    it("Should allow a user to vote and increment vote count", async function () {
        // Create a new proposal.
        await voting.createProposal("Proposal 1");

        // Vote on the first proposal.
        await voting.vote(0);

        // Retrieve the proposal details.
        const proposal = await voting.getProposal(0);

        // Verify that the vote count is 1.
        expect(proposal[1]).to.equal(1);
    });

    // Test case: Should not allow a user to vote twice.
    it("Should not allow a user to vote twice", async function () {
        // Create a new proposal.
        await voting.createProposal("Proposal 1");

        // Vote on the first proposal.
        await voting.vote(0);

        // Attempt to vote again, expecting it to fail.
        await expect(voting.vote(0)).to.be.revertedWith("You have already voted.");
    });

    // Test case: Should return the correct vote count.
    it("Should return the correct vote count", async function () {
        // Create a new proposal.
        await voting.createProposal("Proposal 1");

        // Vote on the first proposal.
        await voting.vote(0);

        // Retrieve the proposal details.
        const proposal = await voting.getProposal(0);

        // Verify that the vote count is 1.
        expect(proposal[1]).to.equal(1);
    });
});