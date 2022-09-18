## DAO Joint Venture Starter with Liquidity Bootstrapping

*It's like a DAO treasury swap on steriods!*

More info on the idea [here](https://gist.github.com/anthonymartin/ba5f0755ee506c068a33c23593facbbc). 

## Setup

* Install [Foundry](https://github.com/foundry-rs/foundry)
* run `yarn` from root directory
* from  `packages/forge`, run `anvil --fork-url https://mainnet.infura.io/v3/xxxx --fork-block-number 15555069` and substitute rpc url with a valid one
* import private key `0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80` into metamask
* from `packages/forge` run, `./deploy.sh` - you can add the printed token addresses to metamask


## Run forge tests

* from `packages/forge`, run `forge test -vvv  --fork-url https://mainnet.infura.io/v3/xxxxx --fork-block-number 15555069` and substitute rpc with a valid one