# DAO Joint Venture Starter with Liquidity Bootstrapping

*It's like a DAO treasury swap on steriods!*

More info on the idea [here](https://gist.github.com/anthonymartin/ba5f0755ee506c068a33c23593facbbc). 

## Project Status

- [x] All main contract functions are tested and all tests are passing with correct behavior
- [x] Any number of DAOs can structure a joint venture deal. There is no limit to the number of participating DAOs
- [x] DAOs may deposit (and withdraw) their tokens to collateralize the joint venture token
- [x] When deposit target amounts have been reached, Uniswap pools are created, Arrakis vaults are created, liquidity is deposited to those pools (one pool per DAO Token/JV Token combo), LP tokens and JV tokens are transferred to each DAO treasury
- [x] JV tokens (joint venture tokens) are minted using Set Protocol and are backed by deposited DAO tokens
- [x] Liquidity splits are dynamic
- [ ] UI is completely functional
- [ ] Oracles implemented for valuation logic


## Setup

* Install [Foundry](https://github.com/foundry-rs/foundry)
* run `yarn` from root directory
* from  `packages/forge`, run `anvil --fork-url https://mainnet.infura.io/v3/xxxx --fork-block-number 15555069` and substitute rpc url with a valid one
* import private key `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` into metamask
* from `packages/forge` run, `./deploy.sh` - then can add the logged token addresses to metamask


## Run forge tests

* from `packages/forge`, run `forge test -vvv  --fork-url https://mainnet.infura.io/v3/xxxxx --fork-block-number 15555069` and substitute rpc with a valid one