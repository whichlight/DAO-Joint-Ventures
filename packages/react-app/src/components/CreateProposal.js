import { Contract, ContractFactory } from '@ethersproject/contracts';
import { useEthers } from '@usedapp/core';

import { useDaoInfo, useNewTokenInfo } from '../hooks/infoHooks';
import { DaoInfo } from './DaoInfo';
import { NewTokenInfo } from './NewTokenInfo';

import { abi } from '../contracts/abi';
import { bytecode } from '../contracts/bytecode';
import { useCallback, useEffect, useState } from 'react';

export const CreateProposal = () => {
  const [contractAddress, setContractAddress] = useState('');
  const { activate, library } = useEthers();

  // useEffect(() => activate(), [activate]);

  const daoInfo1 = useDaoInfo();
  const daoInfo2 = useDaoInfo();
  const tokenInfo = useNewTokenInfo();

  const deploy = useCallback(async () => {
    const contractFactory = new ContractFactory(
      abi,
      bytecode,
      library.getSigner()
    );

    contractFactory
      .deploy(
        daoInfo1.daoAddress,
        daoInfo1.numTokens,
        daoInfo2.daoAddress,
        daoInfo2.numTokens,
        daoInfo1.tokenAddress,
        daoInfo2.tokenAddress,
        daoInfo1.split1,
        tokenInfo.tokenName,
        tokenInfo.tokenSymbol,
        111111
      )
      .then(contract => {
        setContractAddress(contract.address);
      });
  }, [daoInfo1, daoInfo2, library, tokenInfo]);

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

      {!contractAddress ? (
        <button disabled={!isValid} onClick={deploy}>
          Deploy
        </button>
      ) : (
        <div>Deployed!: {contractAddress}</div>
      )}
    </div>
  );
};
