// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;

import "./interfaces/IJVProposal.sol";
import "./interfaces/IJVProposalFactory.sol";
import "./interfaces/IERC20.sol";

address constant SET_CREATOR = 0xeF72D3278dC3Eba6Dc2614965308d1435FFd748a;
address constant SET_BASIC_ISSUANCE_MODULE = 0xd8EF3cACe8b4907117a45B0b125c68560532F94D;
address constant UNISWAP_FACTORY = 0x1F98431c8aD98523631AE4a59f267346ea31F984;

contract JVProposal is IJVProposal {
  mapping(address => mapping(address => uint256)) userTokenDeposits;
  mapping(address => uint256) totalDeposits;
  address[] public deployedPools;
  IJVProposalFactory.DaoConfig[] public daoTokenConfigs;
  IJVProposalFactory.JVTokenConfig public jvTokenConfig;
  uint256 public feeTier;

  constructor(
    IJVProposalFactory.DaoConfig[] memory _daoTokenConfigs,
    IJVProposalFactory.JVTokenConfig memory _jvTokenConfig,
    uint256 _feeTier
  ) {
    for (uint256 i; i < _daoTokenConfigs.length; i++) {
      daoTokenConfigs.push(_daoTokenConfigs[i]);
    }
    jvTokenConfig = _jvTokenConfig;
    feeTier = _feeTier;
  }

  function execute() external {
    require(canExecute(), "deposit targets not reached");
  }

  function canExecute() public view returns (bool) {
    for (uint256 i; i < daoTokenConfigs.length; i++) {
      if (
        totalDeposits[daoTokenConfigs[i].tokenAddress] <
        daoTokenConfigs[i].tokenDepositTarget
      ) return false;
    }
    return true;
  }

  function deposit(IERC20 token, uint256 amount) external {
    require(_validToken(token), "invalid token");
    totalDeposits[address(token)] += amount;
    userTokenDeposits[msg.sender][address(token)] += amount;
    token.transferFrom(msg.sender, address(this), amount);
  }

  function withdraw(IERC20 token, uint256 amount) external {
    require(_validToken(token), "invalid token");
    require(
      userTokenDeposits[msg.sender][address(token)] >= amount,
      "insufficient balance"
    );

    totalDeposits[address(token)] -= amount;
    userTokenDeposits[msg.sender][address(token)] -= amount;
    token.transfer(msg.sender, amount);
  }

  function _validToken(IERC20 token) internal returns (bool) {
    for (uint256 i; i < daoTokenConfigs.length; i++) {
      if (daoTokenConfigs[i].tokenAddress == address(token)) return true;
    }
    return false;
  }
}
