// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.3/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts@4.7.3/access/Ownable.sol";

contract NFT is ERC721, Ownable {
    constructor() ERC721("MyToken", "MTK") {}

    function safeMint(address to, uint256 tokenId) public onlyOwner {
        _safeMint(to, tokenId);
    }
}

