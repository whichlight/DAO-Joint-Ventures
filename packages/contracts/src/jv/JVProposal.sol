// SPDX-License-Identifier: AGPL-3.0-or-later
import "./interfaces/IJVProposal.sol";

contract JVProposal is IJVProposal {
  mapping(address => mapping(address => uint256)) userTokenDeposits;

  address[] public deployedPools;

  DaoTokenConfig[] public daoTokenConfigs; 
  JVTokenConfig public jvTokenConfig;
  constructor(DaoTokenConfig[] memory _daoTokenConfigs, JVTokenConfig memory _jvTokenConfig) {
   daoTokenConfigs = _daoTokenConfigs;
   jvTokenConfig = _jvTokenConfig; 
  }
  function execute() external {}
  function deposit() external {}
  function withdraw() external {}
}