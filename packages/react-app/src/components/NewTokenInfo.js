import { Form, Input } from 'antd';

export const NewTokenInfo = ({ tokenInfo }) => (
  <div>
    <h3>New Token</h3>
    <Form>
      <label>
        Token Name
        <Input
          type="text"
          value={tokenInfo.tokenName}
          onChange={tokenInfo.handleTokenNameChange}
        />
      </label>
      <label>
        Token Symbol
        <Input
          type="text"
          value={tokenInfo.tokenSymbol}
          onChange={tokenInfo.handleTokenSymbolChange}
        />
      </label>

      <label>
        % issued to Dao 1
        <Input
          type="number"
          min={0}
          max={100}
          onChange={tokenInfo.handleSplit1Change}
          value={tokenInfo.split1}
        />
      </label>
      <label>
        % issued to Dao 2
        <Input
          type="number"
          min={0}
          max={100}
          onChange={tokenInfo.handleSplit2Change}
          value={tokenInfo.split2}
        />
      </label>
    </Form>
  </div>
);
