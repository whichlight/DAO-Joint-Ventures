// import { useDaoInfo } from '../hooks/daoInfoHooks';

export const DaoInfo = ({ index, daoInfo }) => (
  <div>
    <h3>DAO {index + 1}</h3>
    <form>
      <label>
        DAO Name
        <input
          type="text"
          value={daoInfo.daoName}
          onChange={daoInfo.handleDaoNameChange}
        />
      </label>
      <label>
        DAO Address
        <input
          type="text"
          value={daoInfo.daoAddress}
          onChange={daoInfo.handleDaoAddressChange}
        />
      </label>
      <label>
        Token Contract Address
        <input
          type="text"
          value={daoInfo.tokenAddress}
          onChange={daoInfo.handleTokenAddressChange}
        />
      </label>
      <label>
        Number of tokens
        <input
          type="number"
          value={daoInfo.numTokens}
          onChange={daoInfo.handleNumTokensChange}
        />
      </label>
      <label>
        % split to treasury
        <input
          max={100}
          min={0}
          type="number"
          onChange={daoInfo.handleSplit1Change}
          value={daoInfo.split1}
        />
      </label>
      <label>
        % split to pool
        <input
          type="number"
          min={0}
          max={100}
          onChange={daoInfo.handleSplit2Change}
          value={daoInfo.split2}
        />
      </label>
    </form>
  </div>
);
