const {Web3} = require("web3");
const secret = require('../../secret.json');
const ethers = require('ethers');

let web3 = new Web3("http://localhost:7545");
web3.eth.handleRevert = true

let contractAddress = require('../../build/contracts/CapacityPool.json').networks[5777].address;
let contractAbi = require('../../build/contracts/CapacityPool.json').abi;

let capacityPool = new web3.eth.Contract(contractAbi, contractAddress);

//Generate web3 account from mnemonic using ethers
let wallet = ethers.Wallet.fromPhrase(secret.local.mnemonic);
let account = web3.eth.accounts.privateKeyToAccount(wallet.privateKey);
web3.eth.accounts.wallet.add(account);

//Add offer
// Generate random string of length 14
let randomString = Math.random().toString(36).substring(2, 15) + Math.random().toString(36).substring(2, 15);
//Get timestamp 5min from now
let timestamp = Math.floor(new Date() / 1000 + 300);
//Log adding new offer to the pool in gray colour
console.log('\x1b[37m%s\x1b[0m', "Adding new offer to the pool");
//Log mining transaction in purple colour
console.log('\x1b[35m%s\x1b[0m', "...mining...");
capacityPool.methods.addOffer(randomString, 5, timestamp).send({
    from: account.address,
    gasLimit: 1000000
}).then(res => {
    //Get added offer
    capacityPool.methods.getOffer(randomString).call().then(res => {
        //Check if offer is in the pool
        if (res[0] === randomString) {
            //Console log in colour that test has passed with checkmark
            console.log('\x1b[32m%s\x1b[0m', '\u2713 Offer is in the pool');
            //Console log offer with yellow colour only fields id, seller, price (also convert using Number), state (also convert using Number), expiryTimestamp (also convert using Number) in the ISO format and buyer.
            console.log('\x1b[33m%s\x1b[0m', `Offer: \n id: ${res[0]},\n seller: ${res[1]},\n price: ${Number(res[2])},\n state: ${Number(res[3])},\n expiryTimestamp: ${new Date(Number(res[4]) * 1000).toISOString()},\n buyer: ${res[5]}`);

            console.log('\x1b[37m%s\x1b[0m', "Removing offer from the pool");
            console.log('\x1b[35m%s\x1b[0m', "...mining...");

            //Remove offer from pool
            capacityPool.methods.removeOffer(randomString).send({
                from: account.address,
                gasLimit: 1000000,
            }).then(res => {
                //Get removed offer
                capacityPool.methods.getOffer(randomString).call().then(res => {
                    //Check if offer is in the pool
                    if (Number(res[3]) !== 2 ) {
                        //Console log in colour that test has failed with cross
                        console.log('\x1b[31m%s\x1b[0m', '\u2717 Offer is still in the pool');
                    } else {
                        //Console log in colour that test has passed with checkmark
                        console.log('\x1b[32m%s\x1b[0m', '\u2713 Offer is not in the pool');
                    }
                })
            })
        } else {
            //Console log in colour that test has failed with cross
            console.log('\x1b[31m%s\x1b[0m', '\u2717 Offer is not in the pool');
        }
    })
})

//Change price of offer add 3





