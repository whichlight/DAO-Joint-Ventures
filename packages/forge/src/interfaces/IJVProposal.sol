// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;
import "./IERC20.sol";

interface IJVProposal {
  event Deposit(address indexed account, uint256 amount);
  event Withdraw(address indexed account, uint256 amount);

  function feeTier() external returns (uint256);

  function execute() external;

  function canExecute() external returns (bool);

  function deposit(IERC20 token, uint256 amount) external;

  function withdraw(IERC20 token, uint256 amount) external;

  function userTokenDeposits(address account, IERC20 token)
    external
    returns (uint256);
}
