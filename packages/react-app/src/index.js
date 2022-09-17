import './index.css';

import { DAppProvider, Mainnet, Goerli } from '@usedapp/core';
import React from 'react';
import ReactDOM from 'react-dom';

import App from './App';

const INFURA_PROJECT_ID = 'dad8b43970354452893cee2b2e9d49fb';
const config = {
  readOnlyChainId: Mainnet.chainId,
  readOnlyUrls: {
    [Mainnet.chainId]: 'https://mainnet.infura.io/v3/' + INFURA_PROJECT_ID,
    [Goerli.chainId]: 'https://goerli.infura.io/v3/' + INFURA_PROJECT_ID,
  },
};

ReactDOM.render(
  <React.StrictMode>
    <DAppProvider config={config}>
      <App />
    </DAppProvider>
  </React.StrictMode>,
  document.getElementById('root')
);
