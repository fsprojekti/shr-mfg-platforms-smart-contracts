//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CapacityRegistry {

    //List of capacity providers
    mapping(address => string) public capacityProvidersUrls;
    //Array of capacity providers addresses
    address[] public capacityProvidersAddresses;

    //List of capacity consumers
    mapping(address => string) public capacityConsumersUrls;
    //Array of capacity consumers addresses
    address[] public capacityConsumersAddresses;

    //Add capacity provider
    function addProvider(string memory url) public returns (bool){
        //Check if message sender address is not already registered
        require(bytes(capacityProvidersUrls[msg.sender]).length == 0, "Address already registered");
        //Add capacity provider
        capacityProvidersUrls[msg.sender] = url;
        capacityProvidersAddresses.push(msg.sender);
        return true;
    }

    //Add capacity consumer
    function addConsumer(string memory url) public returns (bool){
        //Check if message sender address is not already registered
        require(bytes(capacityConsumersUrls[msg.sender]).length == 0, "Address already registered");
        //Add capacity consumer
        capacityConsumersUrls[msg.sender] = url;
        capacityConsumersAddresses.push(msg.sender);
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

    //Update capacity consumer
    function updateConsumer(string memory url) public returns (bool){
        //Check if message sender address is registered
        require(bytes(capacityConsumersUrls[msg.sender]).length > 0, "Address not registered");
        //Update capacity consumer
        capacityConsumersUrls[msg.sender] = url;
        return true;
    }

    //Get capacity provider's url
    function getProviderUrl(address capacityProviderAddress) public view returns (string memory){
        return capacityProvidersUrls[capacityProviderAddress];
    }

    //Get capacity consumer's url
    function getConsumerUrl(address capacityConsumerAddress) public view returns (string memory){
        return capacityConsumersUrls[capacityConsumerAddress];
    }

    //Get capacity providers count
    function getProvidersCount() public view returns (uint){
        return capacityProvidersAddresses.length;
    }

    //Get capacity consumers count
    function getConsumersCount() public view returns (uint){
        return capacityConsumersAddresses.length;
    }

    //Get capacity provider's address by index
    function getProviderAddress(uint index) public view returns (address){
        return capacityProvidersAddresses[index];
    }

    //Get capacity consumer's address by index
    function getConsumerAddress(uint index) public view returns (address){
        return capacityConsumersAddresses[index];
    }

    //Get capacity provider's url by index
    function getProviderUrlByIndex(uint index) public view returns (string memory){
        return capacityProvidersUrls[capacityProvidersAddresses[index]];
    }

    //Get capacity consumer's url by index
    function getConsumerUrlByIndex(uint index) public view returns (string memory){
        return capacityConsumersUrls[capacityConsumersAddresses[index]];
    }

    //Get capacity providers addresses
    function getProvidersAddresses() public view returns (address[] memory){
        return capacityProvidersAddresses;
    }

    //Get capacity consumers addresses
    function getConsumersAddresses() public view returns (address[] memory){
        return capacityConsumersAddresses;
    }
}