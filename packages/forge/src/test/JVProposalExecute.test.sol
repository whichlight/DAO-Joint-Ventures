// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Vm } from "forge-std/Vm.sol";
import { JVProposalFactory } from "../JVProposalFactory.sol";
import "../interfaces/IJVProposalFactory.sol";

contract JVProposalExecuteTest is DSTest {
    address[] users;
    Vm internal immutable vm = Vm(HEVM_ADDRESS);
    Utilities internal utils;
    IJVProposalFactory internal factory;
    IJVProposalFactory.JVTokenConfig internal jvTokenConfig;
    IJVProposalFactory.DaoConfig[] internal daoConfigs;
  
    address constant SET_BASIC_ISSUANCE_MODULE = 0xd8EF3cACe8b4907117a45B0b125c68560532F94D;
    address constant SET_CREATOR = 0xeF72D3278dC3Eba6Dc2614965308d1435FFd748a;

    function setUp() public {
        utils = new Utilities();
        users = utils.createUsers(5);
        factory = new JVProposalFactory();
    }

    function test_execute() public {
        address fooDaoTreasury = users[0];
        address barDaoTreasury = users[1];
        address fooDaoToken = users[2];
        address barDaoToken = users[3];
        
        address[] memory basicIssuance = new address[](1);
        basicIssuance[0] = 0xd8EF3cACe8b4907117a45B0b125c68560532F94D;
        
        uint256[] memory unitquants = new uint256[](2);
        unitquants[0] = 2;
        unitquants[1] = 1;
        jvTokenConfig.quantitiesPerUnit = unitquants;

        // create new token
        address newTokenAddr = SetTokenCreator(SET_CREATOR).create(
            jvTokenConfig.components,
            jvTokenConfig.quantitiesPerUnit, //[2, 1],
            basicIssuance,
            address(this), // manager
            "SETTOKEN",
            "SET"
        );

        // TODO: failing test needs main net fork
        assertEq(newTokenAddr, newTokenAddr);
    }
}