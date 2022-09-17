// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Vm } from "forge-std/Vm.sol";
import { JVProposalFactory } from "../JVProposalFactory.sol";
import "../interfaces/IJVProposalFactory.sol";
import "./utils/MockERC20.sol";

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

  function test_create_proposal() public {
    address fooDaoTreasury = users[0];
    address barDaoTreasury = users[1];
    address fooDaoToken = users[2];
    address barDaoToken = users[3];

    daoConfigs.push(); daoConfigs.push();
    (
      IJVProposalFactory.DaoConfig storage fooDaoConfig,
      IJVProposalFactory.DaoConfig storage barDaoConfig
    ) = (daoConfigs[0], daoConfigs[1]);

    vm.label(fooDaoTreasury, "feeDaoTreasury");
    vm.label(barDaoTreasury, "barDaoTreasury");
    vm.label(fooDaoToken, "fooDaoToken");
    vm.label(barDaoToken, "barDaoToken");

    fooDaoConfig.treasuryAddress = fooDaoTreasury;
    fooDaoConfig.tokenAddress = fooDaoToken;
    fooDaoConfig.tokenDepositTarget = 100_000 ether;
    fooDaoConfig.treasurySplit = 50 ether;
    fooDaoConfig.poolSplit = 50 ether;
    fooDaoConfig.mintSplit = 50 ether;

    barDaoConfig.treasuryAddress = barDaoTreasury;
    barDaoConfig.tokenAddress = barDaoToken;
    barDaoConfig.tokenDepositTarget = 100_000 ether;
    barDaoConfig.treasurySplit = 50 ether;
    barDaoConfig.poolSplit = 50 ether;
    barDaoConfig.mintSplit = 50 ether;

    jvTokenConfig.name = "BAZ Token";
    jvTokenConfig.symbol = "BAZ";
    jvTokenConfig.components.push(fooDaoToken);
    jvTokenConfig.components.push(barDaoToken);
    jvTokenConfig.quantitiesPerUnit.push(1 ether);
    jvTokenConfig.quantitiesPerUnit.push(1 ether);

    uint256 feeTier = 3000;

    IJVProposal response = factory.createProposal(
        daoConfigs,
        jvTokenConfig,
        feeTier
    );

    assertEq(address(response), 0x0000000000000000000000000000000000000000);
  }
}
