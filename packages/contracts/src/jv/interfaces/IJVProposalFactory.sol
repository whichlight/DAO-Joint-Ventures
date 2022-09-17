// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;
interface IJVProposalFactory {
    struct DaoConfig {
    uint256 index;
    address treasuryAddress; 
    address tokenAddress;  
    uint256 tokenDepositTarget;  
    uint256 treasurySplit;  
    uint256 poolSplit;  
    uint256 mintSplit;  
  }
  struct JVTokenConfig {  
    string name;
    string symbol;
    address[] components;
    uint256[] quantitiesPerUnit;
  }
  struct PoolConfig {   
    uint256 feeTier;
    address token0;
  }
}