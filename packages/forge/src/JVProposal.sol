// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;

import "./interfaces/IJVProposal.sol";
import "./interfaces/IJVProposalFactory.sol";
import "./interfaces/ISetTokenCreator.sol";
import "./interfaces/IUniswapV3Factory.sol";
import "./interfaces/IUniswapV3Pool.sol";
import "./interfaces/IArrakisVault.sol";
import "./interfaces/IArrakisFactory.sol";
import "./interfaces/IBasicIssuanceModule.sol";
import "./interfaces/IERC20.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

import { console } from "./test/utils/Console.sol";

address constant SET_CREATOR = 0xeF72D3278dC3Eba6Dc2614965308d1435FFd748a;
address constant SET_BASIC_ISSUANCE_MODULE = 0xd8EF3cACe8b4907117a45B0b125c68560532F94D;
address constant UNISWAP_FACTORY = 0x1F98431c8aD98523631AE4a59f267346ea31F984;
address constant ARRAKIS_FACTORY = 0xEA1aFf9dbFfD1580F6b81A3ad3589E66652dB7D9;

contract JVProposal is IJVProposal {
  mapping(address => mapping(IERC20 => uint256))
    public
    override userTokenDeposits;

  mapping(address => uint256) public override totalDeposits;

  IJVProposalFactory.DaoConfig[] public daoTokenConfigs;
  IJVProposalFactory.JVTokenConfig public jvTokenConfig;
  uint256 public feeTier;
  IERC20 public override jvToken;

  constructor(
    IJVProposalFactory.DaoConfig[] memory _daoTokenConfigs,
    IJVProposalFactory.JVTokenConfig memory _jvTokenConfig,
    uint256 _feeTier
  ) {
    for (uint256 i; i < _daoTokenConfigs.length; i++) {
      daoTokenConfigs.push(_daoTokenConfigs[i]);
      IERC20(_daoTokenConfigs[i].tokenAddress).approve(
        SET_BASIC_ISSUANCE_MODULE,
        type(uint256).max
      );
    }

    jvTokenConfig = _jvTokenConfig;
    feeTier = _feeTier;
  }

  function execute()
    external
    override
    returns (
      address,
      address[] memory,
      address[] memory
    )
  {
    require(canExecute(), "deposit targets not reached");

    address _jvToken = _createToken();

    uint256 mintedAmount = _mintJvTokens();

    (
      address[] memory pools,
      address[] memory vaults
    ) = _deployPoolsAndLiquidity(mintedAmount);

    _transferJvTokens();

    return (_jvToken, pools, vaults);
  }

  function _transferJvTokens() internal {
    uint256 balance = IERC20(jvToken).balanceOf(address(this));
    for (uint256 i; i < daoTokenConfigs.length; i++) {
      IJVProposalFactory.DaoConfig memory dao = daoTokenConfigs[i];
      IERC20(jvToken).transfer(
        dao.treasuryAddress,
        (balance * dao.treasurySplit) / 100 ether
      );
    }
  }

  function _mintJvTokens() internal returns (uint256) {
    IBasicIssuanceModule(SET_BASIC_ISSUANCE_MODULE).issue(
      ISetToken(address(jvToken)),
      _getIssuanceAmount(),
      address(this)
    );
    return IERC20(jvToken).balanceOf(address(this));
  }

  function _deployPoolsAndLiquidity(uint256 jvTokenMintedAmount)
    internal
    returns (address[] memory, address[] memory)
  {
    uint256 tokenCount = daoTokenConfigs.length;
    address[] memory vaults = new address[](tokenCount);
    address[] memory pools = new address[](tokenCount);
    
    for (uint256 i; i < tokenCount; i++) {

      address pool = IUniswapV3Factory(UNISWAP_FACTORY).createPool(
        address(jvToken),
        daoTokenConfigs[i].tokenAddress,
        uint24(feeTier)
      );

      // assuming 1 jvToken = 2 dao tokens
      uint160 sqrtPrice = uint160(Math.sqrt(1 ether) * 2**96) / 1_000_000_000;

      IUniswapV3Pool(pool).initialize(sqrtPrice);

      IArrakisVault vault = IArrakisVault(
        IArrakisFactory(ARRAKIS_FACTORY).deployVault(
          address(jvToken),
          daoTokenConfigs[i].tokenAddress,
          uint24(3000),
          daoTokenConfigs[i].treasuryAddress,
          uint16(0),
          int24(-87240),
          int24(87240)
        )
      );

      uint256 amount0Max = (((jvTokenMintedAmount *
        daoTokenConfigs[i].poolSplit) / 100 ether) *
        daoTokenConfigs[i].mintSplit) / 100 ether;

      uint256 amount1Max = IERC20(daoTokenConfigs[i].tokenAddress).balanceOf(
        address(this)
      );

      (, , uint256 mintAmount) = vault.getMintAmounts(amount0Max, amount1Max);

      IERC20(daoTokenConfigs[i].tokenAddress).approve(
        address(vault),
        type(uint256).max
      );

      jvToken.approve(address(vault), type(uint256).max);
      vault.mint(mintAmount, daoTokenConfigs[i].treasuryAddress);

      vaults[i] = address(vault);
      pools[i] = address(pool);
    }
    return (pools, vaults);
  }

  function _getIssuanceAmount() internal view returns (uint256) {
    uint256 issuanceAmount = ((daoTokenConfigs[0].tokenDepositTarget *
      daoTokenConfigs[0].mintSplit) /
      100 ether /
      uint256(jvTokenConfig.quantitiesPerUnit[0])) * 1 ether;

    for (uint256 i = 1; i < daoTokenConfigs.length; i++) {
      issuanceAmount = Math.min(
        issuanceAmount,
        ((daoTokenConfigs[i].tokenDepositTarget *
          daoTokenConfigs[i].mintSplit) /
          100 ether /
          uint256(jvTokenConfig.quantitiesPerUnit[0])) * 1 ether
      );
    }
    return issuanceAmount;
  }

  function _createToken() internal returns (address) {
    int256[] memory quantitiesPerUnit = jvTokenConfig.quantitiesPerUnit;
    address[] memory _modules = new address[](1);
    _modules[0] = SET_BASIC_ISSUANCE_MODULE;
    jvToken = IERC20(
      address(
        ISetTokenCreator(SET_CREATOR).create(
          jvTokenConfig.components,
          quantitiesPerUnit,
          _modules,
          address(this), // manager
          jvTokenConfig.name,
          jvTokenConfig.symbol
        )
      )
    );

    IBasicIssuanceModule(SET_BASIC_ISSUANCE_MODULE).initialize(
      address(jvToken),
      address(0)
    );

    return address(jvToken);
  }

  function canExecute() public view returns (bool) {
    for (uint256 i; i < daoTokenConfigs.length; i++) {
      if (
        totalDeposits[daoTokenConfigs[i].tokenAddress] <
        daoTokenConfigs[i].tokenDepositTarget
      ) return false;
    }
    return true;
  }

  function deposit(IERC20 token, uint256 amount) external {
    require(_validToken(token), "invalid token");
    totalDeposits[address(token)] += amount;
    userTokenDeposits[msg.sender][token] += amount;
    token.transferFrom(msg.sender, address(this), amount);
    emit Deposit(msg.sender, amount, address(token));
  }

  function withdraw(IERC20 token, uint256 amount) external {
    require(_validToken(token), "invalid token");
    require(
      userTokenDeposits[msg.sender][token] >= amount,
      "insufficient balance"
    );

    totalDeposits[address(token)] -= amount;
    userTokenDeposits[msg.sender][token] -= amount;
    token.transfer(msg.sender, amount);
    emit Withdraw(msg.sender, amount, address(token));
  }

  function _validToken(IERC20 token) internal view returns (bool) {
    for (uint256 i; i < daoTokenConfigs.length; i++) {
      if (daoTokenConfigs[i].tokenAddress == address(token)) return true;
    }
    return false;
  }
}
