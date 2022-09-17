import { Contract } from '@ethersproject/contracts';
import {
  shortenAddress,
  useCall,
  useEthers,
  useLookupAddress,
} from '@usedapp/core';
import React, { useEffect, useMemo, useState } from 'react';

import './App.css';

import { Body, Button, Container, Header, Image, Link } from './components';
import logo from './ethereumLogo.png';

import { addresses, abis } from '@my-app/contracts';
import { DaoInfo } from './components/DaoInfo';
import { NewTokenInfo } from './components/NewTokenInfo';

function WalletButton() {
  const [rendered, setRendered] = useState('');

  const ens = useLookupAddress();
  const { account, activateBrowserWallet, deactivate, error } = useEthers();

  useEffect(() => {
    if (ens) {
      setRendered(ens);
    } else if (account) {
      setRendered(shortenAddress(account));
    } else {
      setRendered('');
    }
  }, [account, ens, setRendered]);

  useEffect(() => {
    if (error) {
      console.error('Error while connecting wallet:', error.message);
    }
  }, [error]);

  return (
    <Button
      onClick={() => {
        if (!account) {
          activateBrowserWallet();
        } else {
          deactivate();
        }
      }}
    >
      {rendered === '' && 'Connect Wallet'}
      {rendered !== '' && rendered}
    </Button>
  );
}

function App() {
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
    </div>
  );
}

export default App;
