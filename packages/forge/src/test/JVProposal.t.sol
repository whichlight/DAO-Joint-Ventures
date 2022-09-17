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

  function test_construction() public {
    IJVProposal proposal = _proposal();
    assertEq(address(proposal), 0xf5a2fE45F4f1308502b1C136b9EF8af136141382);
  }

  function test_fee_tier() public {
    assertEq(_proposal().feeTier(), 3000);
  }

  function test_execute() public {
    IJVProposal proposal = _proposal();
    _depositTargetAmounts(proposal);
    address[3] memory deployedAddresses = proposal.execute();
    vm.label(deployedAddresses[0], 'jvToken');
    assertEq(IERC20(deployedAddresses[0]).balanceOf(address(proposal)), 100_000 ether);
    assertEq(deployedAddresses[0], 0xc84225f52C1cd66Af2cC7a5497A715f79BaFa7ee);
  }


  function _depositTargetAmounts(IJVProposal proposal) internal {
    IERC20 token0 = IERC20(address(tokens[0]));
    IERC20 token1 = IERC20(address(tokens[1]));
    vm.startPrank(alice);
    token0.approve(address(proposal), 100_000 ether);
    token1.approve(address(proposal), 100_000 ether);
    proposal.deposit(token0, 100_000 ether);
    proposal.deposit(token1, 100_000 ether);
  }

  function test_deposit() public {
    IERC20 token = IERC20(address(tokens[0]));
    IJVProposal proposal = _proposal();
    vm.startPrank(alice);
    token.approve(address(proposal), 100_000 ether);
    proposal.deposit(token, 100_000 ether);

    assertEq(proposal.userTokenDeposits(alice, token), 100_000 ether);
    assertEq(proposal.totalDeposits(address(token)), 100_000 ether);
    assertEq(token.balanceOf(address(proposal)), 100_000 ether);
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

}
