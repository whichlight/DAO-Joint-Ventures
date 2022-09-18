// SPDX-License-Identifier: AGPL-3.0-or-later
pragma solidity ^0.8.15;

import {MockERC20} from "./test/utils/MockERC20.sol";

contract MockTokens {
  address public foo;
  address public bar;
  constructor() {
    foo = address(new MockERC20("FooDAO", "FOO", 18));
    bar = address(new MockERC20("BarDAO", "BAR", 18));
    MockERC20(foo).mint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 1_000_000 ether);
    MockERC20(bar).mint(0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266, 1_000_000 ether);
  }
}