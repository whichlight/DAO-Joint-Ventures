// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.15;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract MockERC20 is ERC20 {
  uint8 public __decimals = 18;

  constructor(
    string memory _name,
    string memory _symbol,
    uint8 _decimals
  ) ERC20(_name, _symbol) {
    __decimals = _decimals;
    _mint(msg.sender, 1_000_000 ether);
  }

  function decimals() public view virtual override returns (uint8) {
    return __decimals;
  }

  function mint(address to_, uint256 amount_) public {
    _mint(to_, amount_);
  }

  function burn(address from_, uint256 amount_) public {
    _burn(from_, amount_);
  }
}
