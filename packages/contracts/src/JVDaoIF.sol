// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./ERC20.sol";

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
        ERC20(tokenAdd0).transferFrom(dao0, address(0), nTokens0);
        ERC22(tokenAdd1).transferFrom(dao1, address(0), nTokens1);

        // create new token
        address newTokenAddr = createToken(tokenName, tokenSymbol, 100);

        // do the split
        ERC20(newTokenAddr).transfer(dao0, tokenSupply * split);
        ERC20(newTokenAddr).transfer(dao1, tokenSupply * (1-split));
    }
}

