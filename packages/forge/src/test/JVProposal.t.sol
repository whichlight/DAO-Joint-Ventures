// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Vm } from "forge-std/Vm.sol";
import { JVProposalFactory } from "../JVProposalFactory.sol";
import { JVProposal } from "../JVProposal.sol";
import "../interfaces/IJVProposalFactory.sol";
import "./utils/MockERC20.sol";
import "./Setup.sol";

contract JVProposalFactoryTest is DSTest, Setup {

  function test_fee_tier() public {
    IJVProposalFactory.JVTokenConfig memory tokenConfig = jvTokenConfig;
    uint256 feeTier = 3000;
    IJVProposal proposal = new JVProposal(daoConfigs, tokenConfig, feeTier);

    assertEq(proposal.feeTier(), 3000);
  }

  function test_create_proposal() public {
  }
}
