// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AuctionManager {
    struct Auction {
        uint256 auctionId;
        string itemName;
        string description;
        string imageUrl;
        address seller;
        uint256 startingBid;
        uint256 highestBid;
        address highestBidder;
        uint256 endTime;
        bool isActive;
    }

    uint256 public auctionCount; // Counter for auction IDs
    mapping(uint256 => Auction) public auctions; // Mapping of auction ID to Auction

    event AuctionCreated(
        uint256 auctionId,
        string itemName,
        address seller,
        uint256 endTime
    );
    event NewBid(uint256 auctionId, address bidder, uint256 amount);
    event AuctionEnded(uint256 auctionId, address winner, uint256 amount);

    // Create a new auction
    function createAuction(
        string memory itemName,
        string memory description,
        string memory imageUrl,
        uint256 startingBid,
        uint256 duration
    ) public {
        auctionCount++;
        uint256 endTime = block.timestamp + duration;

        auctions[auctionCount] = Auction({
            auctionId: auctionCount,
            itemName: itemName,
            description: description,
            seller: msg.sender,
            startingBid: startingBid,
            highestBid: 0,
            highestBidder: address(0),
            endTime: endTime,
            isActive: true,
            imageUrl: imageUrl
        });

        emit AuctionCreated(auctionCount, itemName, msg.sender, endTime);
    }

    // Place a bid
    function placeBid(uint256 auctionId) public payable {
        Auction storage auction = auctions[auctionId];
        require(auction.isActive, "Auction is not active");
        require(block.timestamp < auction.endTime, "Auction has ended");
        require(
            msg.value > auction.highestBid,
            "Bid must be higher than the current highest bid"
        );

        // Refund the previous highest bidder
        if (auction.highestBidder != address(0)) {
            payable(auction.highestBidder).transfer(auction.highestBid);
        }

        // Update the auction with the new highest bid
        auction.highestBid = msg.value;
        auction.highestBidder = msg.sender;

        emit NewBid(auctionId, msg.sender, msg.value);
    }

    // End an auction and payout to the seller
    function endAuction(uint256 auctionId) public {
        Auction storage auction = auctions[auctionId];
        require(
            block.timestamp >= auction.endTime,
            "Auction has not ended yet"
        );
        require(auction.isActive, "Auction is not active");

        auction.isActive = false;

        if (auction.highestBid > 0) {
            // Transfer the funds to the seller
            payable(auction.seller).transfer(auction.highestBid);
            emit AuctionEnded(
                auctionId,
                auction.highestBidder,
                auction.highestBid
            );
        } else {
            emit AuctionEnded(auctionId, address(0), 0);
        }
    }

    // Get auction details
    function getAuction(
        uint256 auctionId
    ) public view returns (Auction memory) {
        return auctions[auctionId];
    }

    // Get all auctions
    function getAllAuctions() public view returns (Auction[] memory) {
        Auction[] memory _auctions = new Auction[](auctionCount);
        for (uint256 i = 1; i <= auctionCount; i++) {
            _auctions[i - 1] = auctions[i];
        }
        return _auctions;
    }

    // Get all active auctions
    function getActiveAuctions() public view returns (Auction[] memory) {
        uint256 activeAuctionCount = 0;
        for (uint256 i = 1; i <= auctionCount; i++) {
            if (auctions[i].isActive) {
                activeAuctionCount++;
            }
        }

        Auction[] memory _auctions = new Auction[](activeAuctionCount);
        uint256 index = 0;
        for (uint256 i = 1; i <= auctionCount; i++) {
            if (auctions[i].isActive) {
                _auctions[index] = auctions[i];
                index++;
            }
        }
        return _auctions;
    }

    // Get bids for an auction sorted by highest bid
    function getBids(
        uint256 auctionId
    ) public view returns (address[] memory, uint256[] memory) {
        Auction storage auction = auctions[auctionId];
        address[] memory bidders = new address[](
            auction.highestBidder == address(0) ? 0 : 1
        );
        uint256[] memory amounts = new uint256[](
            auction.highestBidder == address(0) ? 0 : 1
        );

        if (auction.highestBidder != address(0)) {
            bidders[0] = auction.highestBidder;
            amounts[0] = auction.highestBid;
        }

        return (bidders, amounts);
    }

    function getAuctionsBySeller(
        address seller
    ) public view returns (Auction[] memory) {
        uint256 sellerAuctionCount = 0;
        for (uint256 i = 1; i <= auctionCount; i++) {
            if (auctions[i].seller == seller) {
                sellerAuctionCount++;
            }
        }

        Auction[] memory _auctions = new Auction[](sellerAuctionCount);
        uint256 index = 0;
        for (uint256 i = 1; i <= auctionCount; i++) {
            if (auctions[i].seller == seller) {
                _auctions[index] = auctions[i];
                index++;
            }
        }
        return _auctions;
    }
}
