import { Button, Layout, Col, Row } from 'antd';
import { shortenAddress, useEthers, useLookupAddress } from '@usedapp/core';
import React, { useEffect, useState } from 'react';

import './App.css';

const { Header, Content } = Layout;

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
      <Header>
        <Col span={24}>
          <Row align="middle" justify="space-between">
            Header <WalletButton />
          </Row>
        </Col>
      </Header>
      <Content style={{ padding: '64px' }}>{children}</Content>
    </div>
  );
}

export default App;
