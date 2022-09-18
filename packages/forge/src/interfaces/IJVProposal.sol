// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;
import "./IERC20.sol";

interface IJVProposal {
  event Deposit(address indexed account, uint256 amount, address token);
  event Withdraw(address indexed account, uint256 amount, address token);

  function jvToken() external returns (IERC20);

  function feeTier() external returns (uint256);

  function execute() external returns (address, address[] memory, address[] memory);

  function canExecute() external returns (bool);

  function deposit(IERC20 token, uint256 amount) external;

  function withdraw(IERC20 token, uint256 amount) external;

  function userTokenDeposits(address account, IERC20 token)
    external
    returns (uint256);

  function totalDeposits(address token) external returns (uint256);
}
