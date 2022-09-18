import { Form, Input, InputNumber, Typography } from 'antd';

const { Title } = Typography;

export const NewTokenInfo = ({ tokenInfo }) => (
  <div>
    <Title level={3}>New Token</Title>
    <Form>
      <label>
        Token Name
        <Input
          value={tokenInfo.tokenName}
          onChange={tokenInfo.handleTokenNameChange}
        />
      </label>
      <label>
        Token Symbol
        <Input
          value={tokenInfo.tokenSymbol}
          onChange={tokenInfo.handleTokenSymbolChange}
        />
      </label>
      <label>
        % issued to Dao 1{' '}
        <InputNumber
          min={0}
          max={100}
          onChange={tokenInfo.handleSplit1Change}
          value={tokenInfo.mintSplit}
        />
      </label>
      <label>
        % issued to Dao 2{' '}
        <InputNumber
          min={0}
          max={100}
          onChange={tokenInfo.handleSplit2Change}
          value={tokenInfo.mintSplit}
        />
      </label>
    </Form>
  </div>
);
