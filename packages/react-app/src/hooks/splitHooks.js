import { useCallback, useState } from 'react';

export const useSplit = () => {
  const [split1, setSplit1] = useState(50);
  const [split2, setSplit2] = useState(50);

  const handleSplit1Change = useCallback(value => {
    setSplit1(value);
    setSplit2(100 - value);
  }, []);

  const handleSplit2Change = useCallback(value => {
    setSplit2(value);
    setSplit1(100 - value);
  }, []);

  return { split1, split2, handleSplit1Change, handleSplit2Change };
};
