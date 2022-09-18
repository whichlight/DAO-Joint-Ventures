// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Vm } from "forge-std/Vm.sol";
import { JVProposalFactory } from "../JVProposalFactory.sol";
import { JVProposal } from "../JVProposal.sol";
import "../interfaces/IJVProposalFactory.sol";
import "../interfaces/IJVProposal.sol";
import "./utils/MockERC20.sol";

abstract contract Setup is DSTest {
  Vm internal immutable vm = Vm(HEVM_ADDRESS);

  Utilities internal utils;

  IJVProposalFactory internal factory;
  IJVProposalFactory.JVTokenConfig internal jvTokenConfig;
  IJVProposalFactory.DaoConfig[] internal daoConfigs;

  address[] users;
  address alice;
  address bob;

  MockERC20[] tokens;

  function setUp() public {

    utils = new Utilities();
    users = utils.createUsers(5);

    address fooDaoTreasury = users[0];
    address barDaoTreasury = users[1];

    alice = users[2];
    bob = users[3];

    tokens.push(new MockERC20("BarDAO", "BAR", 18));
    tokens.push(new MockERC20("FooDAO", "FOO", 18));

    (address fooDaoToken, address barDaoToken) = (
      address(tokens[0]),
      address(tokens[1])
    );
    _mint();


    daoConfigs.push();
    daoConfigs.push();
    (
      IJVProposalFactory.DaoConfig storage fooDaoConfig,
      IJVProposalFactory.DaoConfig storage barDaoConfig
    ) = (daoConfigs[0], daoConfigs[1]);

    vm.label(alice, "alice");
    vm.label(bob, "bob");
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
    jvTokenConfig.quantitiesPerUnit.push(.5 ether);
    jvTokenConfig.quantitiesPerUnit.push(.5 ether);
  }

  function _mint() internal {
    tokens[0].mint(alice, 1_000_000 ether);
    tokens[1].mint(alice, 1_000_000 ether);
    tokens[1].mint(bob, 1_000_000 ether);
    tokens[1].mint(bob, 1_000_000 ether);
  }
}
