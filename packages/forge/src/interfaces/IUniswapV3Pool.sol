// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;
interface IUniswapV3Pool {
  function initialize(uint160 sqrtPriceX96) external;
    function mint(
        address recipient,
        int24 tickLower,
        int24 tickUpper,
        uint128 amount,
        bytes memory data
  ) external returns (uint256 amount0, uint256 amount1);
}