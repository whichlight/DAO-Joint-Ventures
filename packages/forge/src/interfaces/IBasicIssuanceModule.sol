// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;
interface ISetToken {}
interface IBasicIssuanceModule {
    function issue(
      ISetToken _setToken, 
      uint256 _quantity,
      address _to
  ) external;
  function initialize(address setToken, address preHook) external;
}
