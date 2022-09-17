// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;

import "./interfaces/IJVProposal.sol";

contract JVProposal is IJVProposal {
  address constant SET_CREATOR = 0xeF72D3278dC3Eba6Dc2614965308d1435FFd748a;
  address constant SET_BASIC_ISSUANCE_MODULE =
    0xd8EF3cACe8b4907117a45B0b125c68560532F94D;
  address constant UNISWAP_FACTORY = 0x1F98431c8aD98523631AE4a59f267346ea31F984;

  mapping(address => mapping(address => uint256)) userTokenDeposits;

  address[] public deployedPools;

  DaoTokenConfig[] public daoTokenConfigs;
  JVTokenConfig public jvTokenConfig;

  constructor(
    DaoTokenConfig[] memory _daoTokenConfigs,
    JVTokenConfig memory _jvTokenConfig
  ) {
    for (uint256 i; i < _daoTokenConfigs.length; i++) {
      daoTokenConfigs[i] = _daoTokenConfigs[i];
    }
    jvTokenConfig = _jvTokenConfig;
  }

  function execute() external {}

  function deposit() external {}

  function withdraw() external {}
}
