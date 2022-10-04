// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/draft-ERC20Permit.sol";

contract FNFT is ERC20, Ownable, ERC20Permit, ERC721Holder {
    IERC721 public collection;
    uint256 public tokenId;
    uint256 public curatorFee;
    bool public initialized=false;
    uint256 public lastClaimed;
    // bool public forSale=false;
    // bool public canRedeem=false;
    // uint256 public salePrice;

    constructor(string memory tokenName, string memory tokenSymbol) ERC20(tokenName, tokenSymbol)  ERC20Permit(tokenName) {}

    function initialize(address _collection, uint256 _tokenId, uint256 _supply, uint256 _curatorFee) external onlyOwner{
        require(!initialized, "Already initialized");
        require(_supply>0, "Invalid supply");
        collection = IERC721(_collection);
        collection.safeTransferFrom(msg.sender, address(this), _tokenId);
        tokenId = _tokenId;

        curatorFee = _curatorFee;
        initialized=true;
        lastClaimed = block.timestamp;
        _mint(msg.sender, _supply);
    }

    function claimCuratorFee() external onlyOwner{
        uint256 currentAnnualFee = curatorFee * totalSupply() / 1000000000000000000; 
        uint256 feePerSecond = currentAnnualFee / 31536000;
        uint256 sinceLastClaim = block.timestamp - lastClaimed;
        uint256 curatorMint = sinceLastClaim * feePerSecond;
        _mint(msg.sender, curatorMint);
        lastClaimed = block.timestamp;
    }

    // function putForSale(uint256 price) external onlyOwner{
    //     salePrice=price;
    //     forSale=true;
    // }

    // function purchase() external payable{
    //     require(forSale, "Not for sale");
    //     require(msg.value >= salePrice, "Invalid amount sent");
    //     collection.transferFrom(address(this), msg.sender, tokenId);
    //     forSale=false;
    //     canRedeem = true;
    // }

    // function redeem(uint256 _amount) external{
    //     require(canRedeem, "Cannot reddem");
    //     uint256 totalEther = address(this).balance;
    //     uint256 toRedeem = _amount * totalEther/totalSupply();
    //     _burn(msg.sender, _amount);
    //     payable(msg.sender).transfer(toRedeem);
    // }
}