import { Button } from 'antd';
import { shortenAddress, useEthers, useLookupAddress } from '@usedapp/core';
import React, { useEffect, useState } from 'react';

import './App.css';

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

function App({ children }) {
  return (
    <div>
      <header>
        Header <WalletButton />
      </header>
      {children}
    </div>
  );
}

export default App;
