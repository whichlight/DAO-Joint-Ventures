// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;

interface IArrakisVault {
  function getMintAmounts(uint256 amount0Max, uint256 amount1Max)
    external
    view
    returns (
      uint256 amount0,
      uint256 amount1,
      uint256 mintAmount
    );

  function mint(uint256 mintAmount, address receiver)
    external
    returns (
      uint256 amount0,
      uint256 amount1,
      uint128 liquidityMinted
    );
}
