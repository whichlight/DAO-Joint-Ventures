// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;
import "./IJVProposal.sol";

interface IJVProposalFactory {
  struct DaoConfig {
    address treasuryAddress;
    address tokenAddress;
    uint256 tokenDepositTarget;
    uint256 treasurySplit; // % of remaining minted jv token supply to transfer to treasury after liquidity is deployed to exchanges
    uint256 poolSplit; // % of minted supply to use for pool liquidity
    uint256 mintSplit; // % of dao tokens to use for minting
  }
  struct JVTokenConfig {
    string name;
    string symbol;
    address[] components;
    int256[] quantitiesPerUnit;
  }
  struct PoolConfig {
    uint256 feeTier;
    address token0;
  }

  function createProposal(
    DaoConfig[] memory _daoConfigs,
    JVTokenConfig memory _jvTokenConfig,
    uint256 feeTier
  ) external returns (IJVProposal);
}
