// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.7;

import "./JVDaoIF.sol";

contract JVDAOFactory {
    function create(
        // DAO0
        address dao0,
        uint256 numTokens0,
        address tokenAdd0,
        // DAO1
        address dao1,
        uint256 numTokens1,
        address tokenAdd1,
        // NEW OWNER
        address newOwner,
        uint256 split,
        string memory tokenName,
        string memory tokenSymbol,
        uint256 tokenSupply
    ) public returns (JVDaoIF) {
        JVDaoIF jvd = new JVDaoIF(
            dao0,
            numTokens0,
            tokenAdd0,
            dao1,
            numTokens1,
            tokenAdd1,
            newOwner,
            split,
            tokenName,
            tokenSymbol,
            tokenSupply
        );

       return jvd;
    }
}
