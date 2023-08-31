//Create ERC20 token with initial issuance of 1e6
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract CPLToken is ERC20 {
    constructor() ERC20("CPLToken", "CPL") {
        _mint(msg.sender, 1e24);
    }
}