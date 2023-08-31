//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CapacityPool {
    struct Offer {
        // Id of the offer
        string id;
        // The entity that post an offer to the pool
        address seller;
        // Price for the offer
        uint price;
        //0 new offer, 1 - accepted, 2 - removed
        uint state;
        // The date when the offer expires
        uint expiryTimestamp;
        // The entity that accepted the offer
        address buyer;
    }

    Offer[] public offers;

    function isOfferUnique(string memory id) public view returns (bool){
        for (uint i = 0; i < offers.length; i++) {
            if (keccak256(abi.encodePacked(offers[i].id)) == keccak256(abi.encodePacked(id))) {
                return false;
            }
        }
        return true;
    }

    function addOffer(string memory id, uint price, uint expiryTimestamp) public returns (Offer memory){
        //Check if id is unique
        require(isOfferUnique(id), "Offer id is not unique");
        //Check expiration date
        require(expiryTimestamp > block.timestamp, "Expiration date is in the past");
        offers.push(Offer(id, msg.sender, price, 0, expiryTimestamp, address(0)));
        return offers[offers.length - 1];
    }

    //Remove offer
    function removeOffer(string memory offerId) public returns (bool){
        //Get offer
        uint offerIndex = getOfferIndex(offerId);
        //Must be the offer owner
        require(offers[offerIndex].seller == msg.sender, "You are not the offer owner");
        //Check if offer is available
        require(offers[offerIndex].state == 0, "Offer is not available");
        //Check if offer is expired
        require(offers[offerIndex].expiryTimestamp > block.timestamp, "Offer is expired");
        offers[offerIndex].state = 2;
        return true;
    }

    //Find offer from offer id revert if not found
    function getOffer(string memory offerId) public view returns (Offer memory){
        for (uint i = 0; i < offers.length; i++) {
            if (keccak256(abi.encodePacked(offers[i].id)) == keccak256(abi.encodePacked(offerId))) {
                return offers[i];
            }
        }
        revert("Offer not found");
    }

    //Get offer index from id revert if not found
    function getOfferIndex(string memory offerId) public view returns (uint){
        for (uint i = 0; i < offers.length; i++) {
            if (keccak256(abi.encodePacked(offers[i].id)) == keccak256(abi.encodePacked(offerId))) {
                return i;
            }
        }
        revert("Offer not found");
    }

    function acceptOffer(string memory offerId) public returns (bool){
        //Get offer
        uint offerIndex = getOfferIndex(offerId);
        //Check if offer is expired
        require(offers[offerIndex].expiryTimestamp > block.timestamp, "Offer is expired");

        //Check if offer is available
        require(offers[offerIndex].state == 0, "Offer is not available");

        offers[offerIndex].buyer = msg.sender;
        offers[offerIndex].state = 1;
        return true;
    }

    //Get all offers
    function getOffers() public view returns (Offer[] memory){
        return offers;
    }

    function isExpired(string memory offerId) public view returns (bool){
        return getOffer(offerId).expiryTimestamp < block.timestamp;
    }

    //Get offers length
    function getOffersLength() public view returns (uint){
        return offers.length;
    }
}