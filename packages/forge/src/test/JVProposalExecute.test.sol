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

        // create new token
        address newTokenAddr = SetTokenCreator(SET_CREATOR).create(
            _components, // components
            _units, //[2, 1], // units
            _modules, // [0xeF72D3278dC3Eba6Dc2614965308d1435FFd748a], // modules
            address(this), // manager
            _name,
            _symbol
        );

        assertEq(0, newTokenAddr);
    }
}