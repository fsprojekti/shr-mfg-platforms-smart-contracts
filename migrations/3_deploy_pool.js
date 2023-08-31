const CapacityPool = artifacts.require("CapacityPool");

module.exports = function (deployer) {
  deployer.deploy(CapacityPool);
  console.log(CapacityPool);
};
