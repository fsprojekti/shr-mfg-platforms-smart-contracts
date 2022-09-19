const ManufacturersPool = artifacts.require("ManufacturersPool");

module.exports = function (deployer) {
  deployer.deploy(ManufacturersPool);
};
