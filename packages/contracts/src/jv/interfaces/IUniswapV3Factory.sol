// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.7;
interface IUniswapV3Factory {
    function deploy(
        address tokenA,
        address tokenB,
        uint24 fee
  ) external returns (address pool);
}
