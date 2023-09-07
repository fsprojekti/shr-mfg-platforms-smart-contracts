//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CapacityRegistry {

    //List of capacity providers
    mapping(address => string) public capacityProvidersUrls;
    //Array of capacity providers addresses
    address[] public capacityProvidersAddresses;

    //Add capacity provider
    function addProvider(string memory url) public returns (bool){
        //Check if message sender address is not already registered
        require(bytes(capacityProvidersUrls[msg.sender]).length == 0, "Address already registered");
        //Add capacity provider
        capacityProvidersUrls[msg.sender] = url;
        capacityProvidersAddresses.push(msg.sender);
        return true;
    }

    //Update capacity provider
    function updateProvider(string memory url) public returns (bool){
        //Check if message sender address is registered
        require(bytes(capacityProvidersUrls[msg.sender]).length > 0, "Address not registered");
        //Update capacity provider
        capacityProvidersUrls[msg.sender] = url;
        return true;
    }

    //Get capacity provider's url
    function getProviderUrl(address capacityProviderAddress) public view returns (string memory){
        return capacityProvidersUrls[capacityProviderAddress];
    }

    //Get capacity providers count
    function getProvidersCount() public view returns (uint){
        return capacityProvidersAddresses.length;
    }

    //Get capacity provider's address by index
    function getProviderAddress(uint index) public view returns (address){
        return capacityProvidersAddresses[index];
    }

    //Get capacity provider's url by index
    function getProviderUrlByIndex(uint index) public view returns (string memory){
        return capacityProvidersUrls[capacityProvidersAddresses[index]];
    }

    //Get capacity providers addresses
    function getProvidersAddresses() public view returns (address[] memory){
        return capacityProvidersAddresses;
    }
}