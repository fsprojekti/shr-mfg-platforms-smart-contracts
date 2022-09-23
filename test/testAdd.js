const Web3 = require("web3");
let web3 = new Web3("https://rinkeby.infura.io/v3/5b5e5c71a5ed48a1bd63956d8e6ccb5e");
web3.eth.handleRevert = true

let contractAddress = "0x372F96d2623207685e37a5d21fEAA82245A87e0C";
let contractAbi = require('../build/contracts/ManufacturersPool.json').abi;

let contract = new web3.eth.Contract(contractAbi, contractAddress);

//Generate web3 account from private key
let account = web3.eth.accounts.privateKeyToAccount("efbb5c14ad46a6e87cc33f53332b41ab41048e0e49d3ba3e9b5e3b65fac69c44")
web3.eth.accounts.wallet.add(account);


//Add offer
// Generate ranodm string of length 14
let randomString = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
contract.methods.addOffer(randomString,4,Math.floor(new Date()/1000 + 3600)).send({
    from: account.address,
    gasLimit:1000000
})



