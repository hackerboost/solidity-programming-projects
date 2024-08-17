// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

//Contract to whitelist members for minting NFT
contract Whitelist {
    // Maximum number of whitelisted addresses allowed
    uint8 public maxWhitelistedAddresses;

    // Mapping of whitelisted addresses
    mapping(address => bool) public whitelistedAddresses;

    // Number of addresses that have been whitelisted
    uint8 public numAddressesWhitelisted;

    // Constructor to set the max number of whitelisted addresses
    constructor(uint8 _maxWhitelistedAddresses) {
        maxWhitelistedAddresses = _maxWhitelistedAddresses;
    }

    // Function to add the sender's address to the whitelist
    function addAddressToWhitelist() public {
        // Check if the user is already whitelisted
        require(!whitelistedAddresses[msg.sender], "Address already whitelisted");
        // Ensure the limit of whitelisted addresses has not been reached
        require(numAddressesWhitelisted < maxWhitelistedAddresses, "Limit reached");
        // Add the sender's address to the whitelist
        whitelistedAddresses[msg.sender] = true;
        // Increment the number of whitelisted addresses
        numAddressesWhitelisted += 1;
    }
}