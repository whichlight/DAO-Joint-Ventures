const JVDAOFactory = artifacts.require('JVDaoIF.sol');

module.exports = function(deployer) {
  deployer.deploy(JVDAOFactory)
};
