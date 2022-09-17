// SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import { DSTest } from "ds-test/test.sol";
import { Utilities } from "./utils/Utilities.sol";
import { console } from "./utils/Console.sol";
import { Vm } from "forge-std/Vm.sol";
import { JVProposalFactory } from "../JVProposalFactory.sol";
import { JVProposal } from "../JVProposal.sol";
import "../interfaces/IJVProposalFactory.sol";
import "../interfaces/IERC20.sol";
import "./utils/MockERC20.sol";
import "./Setup.sol";

contract JVProposalFactoryTest is DSTest, Setup {
  function _proposal() internal returns (IJVProposal) {
    IJVProposalFactory.JVTokenConfig memory tokenConfig = jvTokenConfig;
    uint256 feeTier = 3000;
    IJVProposal proposal = new JVProposal(daoConfigs, tokenConfig, feeTier);
    return proposal;
  }

  function test_fee_tier() public {
    assertEq(_proposal().feeTier(), 3000);
  }

  function test_deposit() public {
    IERC20 token = IERC20(address(tokens[0]));
    IJVProposal proposal = _proposal();
    vm.startPrank(alice);
    token.approve(address(proposal), 100_000 ether);
    proposal.deposit(token, 100_000 ether);

    assertEq(proposal.userTokenDeposits(alice, token), 100_000 ether);
  }

  function test_withdraw() public {
    IERC20 token = IERC20(address(tokens[0]));
    IJVProposal proposal = _proposal();
    vm.startPrank(alice);
    token.approve(address(proposal), 100_000 ether);
    proposal.deposit(token, 100_000 ether);
    proposal.withdraw(token, 100_000 ether);

    assertEq(proposal.userTokenDeposits(alice, token), 0);
  }

  function test_create_proposal() public {}
}
