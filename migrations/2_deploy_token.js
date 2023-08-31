const CPLToken = artifacts.require("CPLToken");
const web3 = require("web3");

module.exports = function (deployer) {
  deployer.deploy(CPLToken);
};
