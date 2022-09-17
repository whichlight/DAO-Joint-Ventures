import { useCallback, useState } from 'react';
import { useSplit } from './splitHooks';

export const useDaoInfo = () => {
  const [daoName, setDaoName] = useState('');
  const [daoAddress, setDaoAddress] = useState('');
  const [tokenAddress, setTokenAddress] = useState('');
  const [numTokens, setNumTokens] = useState(0);

  const handleDaoNameChange = useCallback(({ target: { value } }) => {
    setDaoName(value);
  }, []);

  const handleDaoAddressChange = useCallback(({ target: { value } }) => {
    setDaoAddress(value);
  }, []);

  const handleTokenAddressChange = useCallback(({ target: { value } }) => {
    setTokenAddress(value);
  }, []);

  const handleNumTokensChange = useCallback(({ target: { value } }) => {
    setNumTokens(value);
  }, []);

  const { split1, split2, handleSplit1Change, handleSplit2Change } = useSplit();

  return {
    daoAddress,
    daoName,
    handleDaoAddressChange,
    handleDaoNameChange,
    handleNumTokensChange,
    handleSplit1Change,
    handleSplit2Change,
    handleTokenAddressChange,
    numTokens,
    split1,
    split2,
    tokenAddress,
  };
};

export const useNewTokenInfo = () => {
  const [tokenName, setTokenName] = useState('');
  const [tokenSymbol, setTokenSymbol] = useState('');

  const handleTokenNameChange = useCallback(({ target: { value } }) => {
    setTokenName(value);
  }, []);

  const handleTokenSymbolChange = useCallback(({ target: { value } }) => {
    setTokenSymbol(value);
  }, []);

  const { split1, split2, handleSplit1Change, handleSplit2Change } = useSplit();

  return {
    handleSplit1Change,
    handleSplit2Change,
    handleTokenNameChange,
    handleTokenSymbolChange,
    split1,
    split2,
    tokenName,
    tokenSymbol,
  };
};
