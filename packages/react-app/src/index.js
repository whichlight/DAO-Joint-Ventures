import './index.css';

import { DAppProvider, Mainnet, Goerli, useEthers } from '@usedapp/core';
import React from 'react';
import ReactDOM from 'react-dom';
import { BrowserRouter, Route, Routes } from 'react-router-dom';

import App from './App';
import { CreateProposal } from './components/CreateProposal';
import { DepositTokens } from './components/DepositTokens';

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
      <BrowserRouter>
        <App>
          <Routes>
            <Route path="/" element={<CreateProposal />} />
            <Route path="/proposals/:proposalId" element={<DepositTokens />} />
          </Routes>
        </App>
      </BrowserRouter>
    </DAppProvider>
  </React.StrictMode>,
  document.getElementById('root')
);
