import { useParams } from "react-router-dom";

export const DepositTokens = ({ props }) => {
  const { proposalId } = useParams();
  return (
    <div style={{ display: "flex", flexDirection: "column", gap: "0.75rem" }}>
      <h2>Venture Overview</h2>
      <div style={{ display: "flex", flexDirection: "column", gap: "0.5rem" }}>
        <div>
          [DAO 1] will issue [Number of Tokens 1] and [DAO 2] will issue [Number
          of Tokens 2] to create a joint DAO token [New Token]. Each [New Token]
          will require [Quantities per unit 1] of [Token 1] and [Quantities per
          unit 2] of [Token 2]. [% to DAO1] of [New Token] will be issued to
          [DAO 1] and [% to DAO2] of [New Token] will be issued to [DAO 2].
        </div>
        <div>
          DAO1 will split the new tokens sending [DAO1 % to treasury] to the
          DAO1 treasury, and [DAO1 % to liquidity pool] to the liquidity pool.
        </div>
        <div>
          DAO2 will split the new tokens sending [DAO2 % to treasury] to the
          DAO2 treasury, and [DAO2 % to liquidity pool] to the liquidity pool.
        </div>
      </div>
      <h2>Funds Deposit and Approval</h2>
      <div style={{ display: "flex", flexDirection: "row", gap: "1.5rem" }}>
        <div>
          <table>
            <tr>
              <th></th>
              <th>Token Target</th>
            </tr>
            <tr>
              <td>FoodDAO</td>
              <td>BarDAO</td>
            </tr>
            <tr>
              <td>100,000.00 FOO</td>
              <td>60,000.00 BAR</td>
            </tr>
          </table>
        </div>
        <div>
          <table>
            <tr>
              <th></th>
              <th>Token Target</th>
            </tr>
            <tr>
              <td>FoodDAO</td>
              <td>BarDAO</td>
            </tr>
            <tr>
              <td>100,000.00 FOO</td>
              <td>60,000.00 BAR</td>
            </tr>
          </table>
        </div>
      </div>
      <div
        style={{
          width: "30rem",
          display: "flex",
          flexDirection: "column",
          gap: "1rem",
        }}
      >
        <div>
          You currently have xyz deposited. You can deposit or widthdraw.
        </div>
        <input
          max={100}
          min={0}
          // onChange={handleSplit1Change}
          // value={split1}
        />
        <div style={{ width: "5rem" }}>
          <button>Deposit</button>
        </div>
        <input
          max={100}
          min={0}
          // onChange={handleSplit1Change}
          // value={split1}
        />

        <div style={{ width: "5rem" }}>
          <button>Withdraw</button>
        </div>
      </div>
    </div>
  );
};
