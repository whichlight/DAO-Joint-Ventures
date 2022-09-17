// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;
import "./interfaces/IJVProposalFactory.sol";
import "./interfaces/IJVProposal.sol";
import "./JVProposal.sol";

contract JVProposalFactory is IJVProposalFactory {
  function createProposal(
    DaoConfig[] memory _daoConfigs,
    JVTokenConfig memory _jvTokenConfig,
    uint256 _feeTier
  ) external override returns (IJVProposal) {
    _daoConfigs;
    _jvTokenConfig;
    _feeTier;
    JVProposal jv = new JVProposal(_daoConfigs, _jvTokenConfig, _feeTier);
    return jv;
  }
}
