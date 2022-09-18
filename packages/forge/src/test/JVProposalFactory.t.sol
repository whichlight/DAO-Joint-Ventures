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


contract JVProposalFactoryTest is DSTest, Setup {
  function test_create_proposal() public {
    IJVProposalFactory factory = new JVProposalFactory();
    uint256 feeTier = 3000;
    IJVProposal response = factory.createProposal(
        daoConfigs,
        jvTokenConfig,
        feeTier
    );

    assertEq(address(response), 0x73A1564465e54a58De2Dbc3b5032fD013fc95aD4);
  }
}
