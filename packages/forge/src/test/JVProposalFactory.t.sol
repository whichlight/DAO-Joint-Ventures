// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Vm } from "forge-std/Vm.sol";
import { JVProposalFactory } from "../JVProposalFactory.sol";
import "../interfaces/IJVProposalFactory.sol";
import "./utils/MockERC20.sol";
import "./Setup.sol";

contract JVProposalFactoryTest is DSTest {
  Vm internal immutable vm = Vm(HEVM_ADDRESS);
  Utilities internal utils;
  IJVProposalFactory internal factory;
  IJVProposalFactory.JVTokenConfig internal jvTokenConfig;
  IJVProposalFactory.DaoConfig[] internal daoConfigs;

  address[] users;
  MockERC20 tokens;

  function setUp() public {
    utils = new Utilities();
    users = utils.createUsers(5);
    factory = new JVProposalFactory();
    //tokens.push(new MockERC20("BarDAO", "BAR", 18));
    //tokens.push(new MockERC20("FooDAO", "FOO", 18));
    // create mock tokens
  }

contract JVProposalFactoryTest is DSTest, Setup {
  function test_create_proposal() public {
    IJVProposalFactory factory = new JVProposalFactory();
    uint256 feeTier = 3000;
    IJVProposal response = factory.createProposal(
        daoConfigs,
        jvTokenConfig,
        feeTier
    );

    assertEq(address(response), 0x0000000000000000000000000000000000000000);
  }
}
