// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;

interface IArrakisFactory {
  function deployVault(
    address tokenA,
    address tokenB,
    uint24 uniFee,
    address manager,
    uint16 managerFee,
    int24 lowerTick,
    int24 upperTick
  ) external returns (address vault);
}
