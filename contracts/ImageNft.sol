// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ImageNFT is ERC721 {
    using Counters for Counters.Counter;
    using SafeMath for uint256;
    Counters.Counter private _tokenIds;

    constructor() ERC721("ImageNFT", "INFT") {}

    struct ImageMetadata {
        string imageUrl;
        uint256 price;
        address owner;
    }

    mapping(uint256 => ImageMetadata) private _imageMetadatas;

    function mint(string memory imageUrl, uint256 price) public returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);

        _imageMetadatas[newItemId] = ImageMetadata({
            imageUrl: imageUrl,
            price: price,
            owner: msg.sender
        });

        return newItemId;
    }

    function getImageUrl(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        return _imageMetadatas[tokenId].imageUrl;
    }

    function getPrice(uint256 tokenId) public view returns (uint256) {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        return _imageMetadatas[tokenId].price;
    }

    function setPrice(uint256 tokenId, uint256 newPrice) public {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        require(msg.sender == ownerOf(tokenId), "ImageNFT: caller is not the owner");
        _imageMetadatas[tokenId].price = newPrice;
    }

    function buy(uint256 tokenId) public payable {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        require(msg.value >= _imageMetadatas[tokenId].price, "ImageNFT: insufficient funds");
        address payable oldOwner = payable(_imageMetadatas[tokenId].owner);
        address payable newOwner = payable(msg.sender);
        uint256 price = _imageMetadatas[tokenId].price;

        _imageMetadatas[tokenId].owner = newOwner;
        _imageMetadatas[tokenId].price = price.mul(150).div(100); // increase price by 50%

        _transfer(oldOwner, newOwner, tokenId);

        oldOwner.transfer(price);
    }

    function cancelSale(uint256 tokenId) public {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        require(msg.sender == _imageMetadatas[tokenId].owner, "ImageNFT: caller is not the owner");
        _imageMetadatas[tokenId].price = 0;
    }
}
