pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";

contract ImageNFT is ERC721 {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("ImageNFT", "INFT") {}

    struct ImageMetadata {
        string imageUrl;
        uint256 price;
        address owner;
        string name;
        uint256 id;
    }

    mapping(uint256 => ImageMetadata) private _imageMetadatas;

    function mint(string memory imageUrl, string memory name, uint256 price) public returns (uint256) {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(msg.sender, newItemId);

        _imageMetadatas[newItemId] = ImageMetadata({
            imageUrl: imageUrl,
            price: price,
            owner: msg.sender,
            name: name,
            id: newItemId
        });

        return newItemId;
    }

    function getImageUrl(uint256 tokenId) public view returns (string memory) {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        return _imageMetadatas[tokenId].imageUrl;
    }

    function getAllImageMetadatas() public view returns (ImageMetadata[] memory) {
        ImageMetadata[] memory metadatas = new ImageMetadata[](_tokenIds.current());
        for (uint256 i = 1; i <= _tokenIds.current(); i++) {
            metadatas[i - 1] = _imageMetadatas[i];
        }
        return metadatas;
    }

    function getPrice(uint256 tokenId) public view returns (uint256) {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        return _imageMetadatas[tokenId].price;
    }

    function setPrice(uint256 tokenId, uint256 newPrice) public {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        require(_msgSender() == ownerOf(tokenId), "ImageNFT: caller is not the owner");
        _imageMetadatas[tokenId].price = newPrice;
    }

    function buy(uint256 tokenId) public payable {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        require(msg.value >= _imageMetadatas[tokenId].price, "ImageNFT: insufficient funds");
        address payable oldOwner = payable(_imageMetadatas[tokenId].owner);
        address payable newOwner = payable(_msgSender());
        uint256 price = _imageMetadatas[tokenId].price;

        _imageMetadatas[tokenId].owner = newOwner;
        _imageMetadatas[tokenId].price = price * 150 / 100; // increase price by 50%

        _transfer(oldOwner, newOwner, tokenId);

        oldOwner.transfer(price);
    }

    function cancelSale(uint256 tokenId) public {
        require(_exists(tokenId), "ImageNFT: token does not exist");
        require(_msgSender() == _imageMetadatas[tokenId].owner, "ImageNFT: caller is not the owner");
        _imageMetadatas[tokenId].price = 0;
    }

    function getOwnedTokens(address owner) public view returns (uint256[] memory) {
        uint256[] memory tokenIds = new uint256[](balanceOf(owner));
        uint256 tokenIndex = 0;

        for (uint256 i = 1; i <= _tokenIds.current(); i++) {
            if (ownerOf(i) == owner) {
                tokenIds[tokenIndex] = i;
                tokenIndex++;
            }
        }

        return tokenIds;
    }
}