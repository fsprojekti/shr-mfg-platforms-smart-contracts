const CapacityRegistry = artifacts.require("CapacityRegistry");

module.exports = function (deployer) {
  deployer.deploy(CapacityRegistry);
  console.log(CapacityRegistry);
};
