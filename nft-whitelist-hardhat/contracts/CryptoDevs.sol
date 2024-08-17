// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./Whitelist.sol";

/**
 * @title CryptoDevs
 * @dev This contract implements the CryptoDevs NFT collection, allowing users to mint NFTs and handle reservations for whitelisted addresses.
 */
contract CryptoDevs is ERC721Enumerable, Ownable {
    // _price is the price of one Crypto Dev NFT
    uint256 public constant _price = 0.01 ether;

    // Max number of CryptoDevs that can ever exist
    uint256 public constant maxTokenIds = 20;

    // Whitelist contract instance
    Whitelist whitelist;

    // Number of tokens reserved for whitelisted members
    uint256 public reservedTokens;
    uint256 public reservedTokensClaimed = 0;

    /**
     * @dev Constructor to initialize the CryptoDevs contract.
     * @param whitelistContract The address of the Whitelist contract.
     */
    constructor(address whitelistContract) ERC721("Crypto Devs", "CD") Ownable(msg.sender) {
        whitelist = Whitelist(whitelistContract);
        reservedTokens = whitelist.maxWhitelistedAddresses();
    }

    /**
     * @dev Mint a new Crypto Dev NFT.
     * Users can mint if they are part of the whitelist with remaining reserved tokens, or by sending enough ETH.
     */
    function mint() public payable {
        // Make sure we always leave enough room for whitelist reservations
        require(totalSupply() + reservedTokens - reservedTokensClaimed < maxTokenIds, "EXCEEDED_MAX_SUPPLY");

        // If user is part of the whitelist, make sure there are still reserved tokens left
        if (whitelist.whitelistedAddresses(msg.sender) && msg.value < _price) {
            // Make sure user doesn't already own an NFT
            require(balanceOf(msg.sender) == 0, "ALREADY_OWNED");
            reservedTokensClaimed += 1;
        } else {
            // If user is not part of the whitelist, make sure they have sent enough ETH
            require(msg.value >= _price, "NOT_ENOUGH_ETHER");
        }
        uint256 tokenId = totalSupply();
        _safeMint(msg.sender, tokenId);
    }

    /**
     * @dev Withdraw all the ether in the contract to the owner of the contract.
     */
    function withdraw() public onlyOwner {
        address _owner = owner();
        uint256 amount = address(this).balance;
        (bool sent, ) =  _owner.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }
}
