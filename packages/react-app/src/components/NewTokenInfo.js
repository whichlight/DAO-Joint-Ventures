export const NewTokenInfo = ({ tokenInfo }) => (
  <div>
    <h3>New Token</h3>
    <form>
      <label>
        Token Name
        <input
          type="text"
          value={tokenInfo.tokenName}
          onChange={tokenInfo.handleTokenNameChange}
        />
      </label>
      <label>
        Token Symbol
        <input
          type="text"
          value={tokenInfo.tokenSymbol}
          onChange={tokenInfo.handleTokenSymbolChange}
        />
      </label>

      <label>
        % issued to Dao 1
        <input
          type="number"
          min={0}
          max={100}
          onChange={tokenInfo.handleSplit1Change}
          value={tokenInfo.split1}
        />
      </label>
      <label>
        % issued to Dao 2
        <input
          type="number"
          min={0}
          max={100}
          onChange={tokenInfo.handleSplit2Change}
          value={tokenInfo.split2}
        />
      </label>
    </form>
  </div>
);
