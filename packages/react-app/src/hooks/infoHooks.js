import { useCallback, useState } from 'react';
import { useSplit } from './splitHooks';

export const useDaoInfo = () => {
  const [daoName, setDaoName] = useState('Name');
  const [daoAddress, setDaoAddress] = useState(
    '0x239cF0671fADb4747A69Bfd83120F4dA783edA96'
  );
  const [tokenAddress, setTokenAddress] = useState(
    '0x239cF0671fADb4747A69Bfd83120F4dA783edA96'
  );
  const [numTokens, setNumTokens] = useState(1000);

  const handleDaoNameChange = useCallback(({ target: { value } }) => {
    setDaoName(value);
  }, []);

  const handleDaoAddressChange = useCallback(({ target: { value } }) => {
    setDaoAddress(value);
  }, []);

  const handleTokenAddressChange = useCallback(({ target: { value } }) => {
    setTokenAddress(value);
  }, []);

  const { split1, split2, handleSplit1Change, handleSplit2Change } = useSplit();

  return {
    daoAddress,
    daoName,
    handleDaoAddressChange,
    handleDaoNameChange,
    setNumTokens,
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
  const [tokenName, setTokenName] = useState('tokenname');
  const [tokenSymbol, setTokenSymbol] = useState('tkyn');

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
