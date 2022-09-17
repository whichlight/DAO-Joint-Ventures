import { useSplit } from '../hooks/splitHooks';

export const DaoInfo = ({ index }) => {
  const { split1, split2, handleSplit1Change, handleSplit2Change } = useSplit();
  return (
    <div>
      <h3>DAO {index + 1}</h3>
      <form>
        <label>
          DAO Name
          <input type="text" />
        </label>
        <label>
          DAO Address
          <input type="text" />
        </label>
        <label>
          Token Contract Address
          <input type="text" />
        </label>
        <label>
          Number of tokens
          <input type="number" />
        </label>
        <label>
          % split to treasury
          <input
            max={100}
            min={0}
            type="number"
            onChange={handleSplit1Change}
            value={split1}
          />
        </label>
        <label>
          % split to pool
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
