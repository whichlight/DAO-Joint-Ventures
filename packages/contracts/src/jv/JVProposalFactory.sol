// SPDX-License-Identifier: AGPL-3.0-or-later
import "./interfaces/IJVProposalFactory.sol";
import "./interfaces/IJVProposal.sol";


contract JVProposalFactory is IJVProposalFactory {
  function createProposal(DaoConfig[] memory _daoConfigs, JVTokenConfig memory  _jvTokenConfig, PoolConfig memory _config) external returns (IJVProposal) {
    
  }
}