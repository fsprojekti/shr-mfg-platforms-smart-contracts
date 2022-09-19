//SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ManufacturerRegister {
    mapping(address => string) public web_address;
    address[] public manufacturers;

    function addManufacturer(string memory url) public returns (bool){
        web_address[msg.sender] = url;
        manufacturers.push(msg.sender);
        return true;
    }

    function removeManufacturer() public returns (bool){
        delete web_address[msg.sender];
        // Remove manufacturer address from array
        for (uint i = 0; i < manufacturers.length; i++) {
            if (manufacturers[i] == msg.sender) {
                manufacturers[i] = manufacturers[manufacturers.length - 1];
                manufacturers.pop();
                break;
            }
        }
        return true;
    }

    function changeManufacturer(string memory url) public returns (bool){
        web_address[msg.sender] = url;
        return true;
    }

    function getManufacturer(address manufacturer) public view returns (string memory){
        return web_address[manufacturer];
    }

    function getManufacturers() public view returns (address[] memory){
        return manufacturers;
    }

    //Get manufacturers and return address and urls
    function getManufacturersAndUrls() public view returns (address[] memory, string[] memory){
        address[] memory addresses = new address[](manufacturers.length);
        string[] memory urls = new string[](manufacturers.length);
        for(uint i = 0; i < manufacturers.length; i++){
            addresses[i] = manufacturers[i];
            urls[i] = getManufacturer(manufacturers[i]);
        }
        return (addresses, urls);
    }
}
