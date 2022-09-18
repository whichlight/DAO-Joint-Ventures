import { useCallback, useState } from 'react';
import { useSplit } from './splitHooks';

export const useDaoInfo = ({treasuryAddress, token, name }) => {
  const [daoName, setDaoName] = useState(name);
  const [daoAddress, setDaoAddress] = useState(
    treasuryAddress
  );
  const [tokenAddress, setTokenAddress] = useState(
    token
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
  const [tokenName, setTokenName] = useState('FooBar Joint Venture');
  const [tokenSymbol, setTokenSymbol] = useState('BAZ');

  const handleTokenNameChange = useCallback(({ target: { value } }) => {
    setTokenName(value);
  }, []);

  const handleTokenSymbolChange = useCallback(({ target: { value } }) => {
    setTokenSymbol(value);
  }, []);

  const { dao1MintSplit, dao2MintSplit, handleSplit1Change, handleSplit2Change } = useSplit();

  return {
    handleSplit1Change,
    handleSplit2Change,
    handleTokenNameChange,
    handleTokenSymbolChange,
    dao1MintSplit,
    dao2MintSplit,
    tokenName,
    tokenSymbol,
  };
};
