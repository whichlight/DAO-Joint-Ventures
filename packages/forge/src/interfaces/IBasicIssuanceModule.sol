interface ISetToken {}
interface IBasicIssuanceModule {
    function issue(
      ISetToken _setToken, 
      uint256 _quantity,
      address _to
  ) external returns (address);
}
