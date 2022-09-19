const ManufacturerRegister = artifacts.require("ManufacturerRegister");

module.exports = function (deployer) {
  deployer.deploy(ManufacturerRegister);
};
