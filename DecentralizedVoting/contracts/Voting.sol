// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

// The Voting contract allows users to create proposals and vote on them.
contract Voting {

    // A struct to represent a proposal.
    struct Proposal {
        string name;         // The name of the proposal.
        uint256 voteCount;   // The number of votes the proposal has received.
    }

    // A mapping to track whether an address has voted.
    mapping(address => bool) public voters;

    // An array to store all proposals.
    Proposal[] public proposals;

    // Function to create a new proposal.
    function createProposal(string memory proposalName) public {
        // Adds a new proposal to the proposals array.
        proposals.push(Proposal({
            name: proposalName,   // Set the proposal's name.
            voteCount: 0          // Initialize the vote count to 0.
        }));
    }

    // Function to vote on a proposal.
    function vote(uint proposalIndex) public {
        // Ensure the voter hasn't already voted.
        require(!voters[msg.sender], "You have already voted.");
        
        // Ensure the proposal index is valid.
        require(proposalIndex < proposals.length, "Invalid proposal.");

        // Mark the voter as having voted.
        voters[msg.sender] = true;
        
        // Increment the vote count for the selected proposal.
        proposals[proposalIndex].voteCount += 1;
    }

    // Function to get the details of a proposal.
    function getProposal(uint proposalIndex) public view returns (string memory, uint256) {
        // Ensure the proposal index is valid.
        require(proposalIndex < proposals.length, "Invalid proposal.");

        // Retrieve the proposal from the array.
        Proposal storage proposal = proposals[proposalIndex];

        // Return the proposal's name and vote count.
        return (proposal.name, proposal.voteCount);
    }
}