// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./ERC20.sol";

interface UniswapV3PoolDeployer {
    function deploy(
        address factory,
        address token0,
        address token1,
        uint24 fee,
        int24 tickSpacing
  ) external returns (address pool);
}
interface Pool {
    function mint(
    address recipient,
    int24 tickLower,
    int24 tickUpper,
    uint128 amount,
    bytes memory data
  ) external returns (uint256 amount0, uint256 amount1);
}

contract JVDaoIF {
    address public dao0;
    address public tokenAdd0;
    uint256 public nTokens0;
    address public dao1;
    address public tokenAdd1;
    uint256 public nTokens1;
    address public newOwner;
    uint256 public split;

    string public tokenName;
    string public tokenSymbol;
    uint256 public tokenSupply;


    constructor(
        address _dao0,
        uint256 _nTokens0,
        address _dao1,
        uint256 _nTokens1,
        address _newOwner,
        address _tokenAdd1,
        address _tokenAdd0,
        uint256 _split,

        string memory _tokenName,
        string memory _tokenSymbol,
        uint256 _tokenSupply
    ) {
        dao0 = _dao0;
        nTokens0 = _nTokens0;
        dao1 = _dao1;
        newOwner = _newOwner;
        nTokens1 = _nTokens1;
        tokenAdd1 = _tokenAdd1;
        tokenAdd0 = _tokenAdd0;
        split = _split;

        tokenName = _tokenName;
        tokenSymbol = _tokenSymbol;
        tokenSupply = _tokenSupply;
        
    }

    function createToken(string memory _name, string memory _symbol,uint _supply) public returns(address){
        ERC20 newToken = new ERC20(_name, _symbol, _supply);
        return address(newToken);
  }


    function mint() public {
        // burn the tokens
        //ERC20(tokenAdd0).transferFrom(dao0, address(0), nTokens0);
        //ERC20(tokenAdd1).transferFrom(dao1, address(0), nTokens1);

        // create new token
        address newTokenAddr = createToken(tokenName, tokenSymbol, 100);

        // do the split
        ERC20(newTokenAddr).transfer(dao0, tokenSupply * split);
        ERC20(newTokenAddr).transfer(dao1, tokenSupply * (1-split));

        // create liquidity pool
        address poolAddr0 = UniswapV3PoolDeployer(newTokenAddr).deploy(newTokenAddr, tokenAdd0, newTokenAddr, 3, 3);
        address poolAddr1 = UniswapV3PoolDeployer(newTokenAddr).deploy(newTokenAddr, tokenAdd1, newTokenAddr, 3, 3);

        // provide liquidity
        // get the pool somehow
        Pool(poolAddr0).mint(
            dao0,
            3, // tickLower
            3, // tickUpper
            (uint128) (tokenSupply * split), // amount
            "" // data
        );

        Pool(poolAddr1).mint(
            dao0,
            3, // tickLower
            3, // tickUpper
            (uint128) (tokenSupply * (1-split)), // amount
            "" // data
        );
    }
}

