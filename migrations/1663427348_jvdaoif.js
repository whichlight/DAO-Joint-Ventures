const jvdaoif = artifacts.require('JVDaoIF')
module.exports = function(deployer) {
  // Use deployer to state migration tasks.
  deployer.deploy(jvdaoif("0x0", 0, "0x0"))
};
