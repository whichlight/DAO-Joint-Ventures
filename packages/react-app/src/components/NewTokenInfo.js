import { useSplit } from '../hooks/splitHooks';

export const NewTokenInfo = () => {
  const { split1, split2, handleSplit1Change, handleSplit2Change } = useSplit();
  return (
    <div>
      <h3>New Token</h3>
      <form>
        <label>
          Token Name
          <input type="text" />
        </label>
        <label>
          Token Symbol
          <input type="text" />
        </label>

        <label>
          % issued to Dao 1
          <input
            type="number"
            min={0}
            max={100}
            onChange={handleSplit1Change}
            value={split1}
          />
        </label>
        <label>
          % issued to Dao 2
          <input
            type="number"
            min={0}
            max={100}
            onChange={handleSplit2Change}
            value={split2}
          />
        </label>
      </form>
    </div>
  );
};
