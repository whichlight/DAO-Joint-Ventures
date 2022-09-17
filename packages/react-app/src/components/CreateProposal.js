import { useMemo, useState } from 'react';

import { DaoInfo } from './DaoInfo';
import { NewTokenInfo } from './NewTokenInfo';

export const CreateProposal = () => {
  const [numDaos] = useState(2);
  // Read more about useDapp on https://usedapp.io/
  // const { error: contractCallError, value: tokenBalance } =
  //   useCall({
  //     contract: new Contract(addresses.ceaErc20, abis.erc20),
  //     method: 'balanceOf',
  //     args: ['0x3f8CB69d9c0ED01923F11c829BaE4D9a4CB6c82C'],
  //   }) ?? {};

  const daos = useMemo(() => [...new Array(numDaos)], [numDaos]);

  return (
    <div>
      {daos.map((_, i) => (
        <DaoInfo index={i} key={i} />
      ))}
      <NewTokenInfo />
      <button>Deploy</button>
    </div>
  );
};
