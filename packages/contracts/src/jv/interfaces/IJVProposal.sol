// SPDX-License-Identifier: AGPL-3.0-or-later
interface IJVProposal {
  struct DaoTokenConfig {  
    uint256 index;  
    uint256 depositThreshold;
    address tokenAddress;
  }
  struct JVTokenConfig {  
    uint256 index;
    address[] components;
    address[] quantitiesPerUnit;
  }
}