import { Form, Input, InputNumber, Typography } from 'antd';

const { Title } = Typography;

export const DaoInfo = ({ index, daoInfo }) => (
  <div style={{ marginBottom: 48 }}>
    <Title level={3}>DAO {index + 1}</Title>
    <Form>
      <label>
        DAO Name
        <Input value={daoInfo.daoName} onChange={daoInfo.handleDaoNameChange} />
      </label>
      <label>
        DAO Address
        <Input
          value={daoInfo.daoAddress}
          onChange={daoInfo.handleDaoAddressChange}
        />
      </label>
      <label>
        Token Contract Address
        <Input
          value={daoInfo.tokenAddress}
          onChange={daoInfo.handleTokenAddressChange}
        />
      </label>
      <label>
        Target # of tokens to deposit{' '}
        <InputNumber
          value={daoInfo.numTokens}
          onChange={daoInfo.setNumTokens}
        />
      </label>
      <label>
        % split to treasury{' '}
        <InputNumber
          max={100}
          min={0}
          onChange={daoInfo.handleSplit1Change}
          value={daoInfo.treasurySplit}
        />
      </label>
      <label>
        % split to pool{' '}
        <InputNumber
          min={0}
          max={100}
          onChange={daoInfo.handleSplit2Change}
          value={daoInfo.poolSplit}
        />
      </label>
    </Form>
  </div>
);
