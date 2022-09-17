import { useDaoInfo, useNewTokenInfo } from '../hooks/infoHooks';
import { DaoInfo } from './DaoInfo';
import { NewTokenInfo } from './NewTokenInfo';

export const CreateProposal = () => {
  // Read more about useDapp on https://usedapp.io/
  // const { error: contractCallError, value: tokenBalance } =
  //   useCall({
  //     contract: new Contract(addresses.ceaErc20, abis.erc20),
  //     method: 'balanceOf',
  //     args: ['0x3f8CB69d9c0ED01923F11c829BaE4D9a4CB6c82C'],
  //   }) ?? {};

  const daoInfo1 = useDaoInfo();
  const daoInfo2 = useDaoInfo();
  const tokenInfo = useNewTokenInfo();

  const isValid =
    daoInfo1.daoAddress &&
    daoInfo1.daoName &&
    daoInfo1.numTokens > 0 &&
    daoInfo1.tokenAddress &&
    daoInfo2.daoAddress &&
    daoInfo2.daoName &&
    daoInfo2.numTokens > 0 &&
    daoInfo2.tokenAddress &&
    tokenInfo.tokenName &&
    tokenInfo.tokenSymbol;

  return (
    <div>
      <DaoInfo index={0} daoInfo={daoInfo1} />
      <DaoInfo index={1} daoInfo={daoInfo2} />
      <NewTokenInfo tokenInfo={tokenInfo} />
      <button disabled={!isValid}>Deploy</button>
    </div>
  );
};
