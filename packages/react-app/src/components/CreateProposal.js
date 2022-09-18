import { Button } from "antd";
import { useEthers, useContractFunction } from "@usedapp/core";

import { useDaoInfo, useNewTokenInfo } from "../hooks/infoHooks";
import { DaoInfo } from "./DaoInfo";
import { NewTokenInfo } from "./NewTokenInfo";

import { abi as JVProposalFactoryABI } from "../contracts/JVProposalFactory";
import { useState } from "react";
import { utils } from "ethers";
import { Contract } from "@ethersproject/contracts";

export const CreateProposal = () => {
  const [contractAddress, setContractAddress] = useState("");
  const { library } = useEthers();

  const daoInfo1 = useDaoInfo({
    treasuryAddress: "0x70997970c51812dc3a010c7d01b50e0d17dc79c8",
    token: "0x2F54D1563963fC04770E85AF819c89Dc807f6a06",
  });
  const daoInfo2 = useDaoInfo({
    treasuryAddress: "0x3c44cdddb6a900fa2b585dd299e03d12fa4293bc",
    token: "0xF342E904702b1D021F03f519D6D9614916b03f37",
  });
  const tokenInfo = useNewTokenInfo();

  const dao1Config = {
    treasuryAddress: daoInfo1.daoAddress,
    tokenAddress: daoInfo1.tokenAddress,
    tokenDepositTarget: daoInfo1.numTokens,
    treasurySplit: daoInfo1.treasurySplit,
    poolSplit: daoInfo1.poolSplit,
    mintSplit: tokenInfo.dao1MintSplit,
  };

  const dao2Config = {
    treasuryAddress: daoInfo1.daoAddress,
    tokenAddress: daoInfo1.tokenAddress,
    tokenDepositTarget: daoInfo1.numTokens,
    treasurySplit: daoInfo1.treasurySplit,
    poolSplit: daoInfo1.poolSplit,
    mintSplit: tokenInfo.dao2MintSplit,
  };

  const contract = new Contract(
    "0x9849832a1d8274aaeDb1112ad9686413461e7101",
    new utils.Interface(JVProposalFactoryABI)
  );

  const { state, send } = useContractFunction(
    contract,
    "createProposal(DaoConfig[],JVTokenConfig,uint256)",
    {
      transactionName: "Wrap",
    }
  );

  const createProposal = () => {
    send(
      [dao1Config, dao2Config],
      {
        name: tokenInfo.name,
        symbol: tokenInfo.tokenSymbol,
        components: [dao1Config.tokenAddress, dao2Config.tokenAddress],
      },
      3000
    );
  };

  //const deploy = useCallback(async () => {
  //  const contractFactory = new ContractFactory(
  //    abi,
  //    bytecode,
  //    library.getSigner()
  //  );

  //  contractFactory
  //    .deploy(
  //      daoInfo1.daoAddress,
  //      daoInfo1.numTokens,
  //      daoInfo2.daoAddress,
  //      daoInfo2.numTokens,
  //      daoInfo1.tokenAddress,
  //      daoInfo2.tokenAddress,
  //      daoInfo1.treasurySplit,
  //      tokenInfo.tokenName,
  //      tokenInfo.tokenSymbol,
  //      111111
  //    )
  //    .then(contract => {
  //      setContractAddress(contract.address);
  //    });
  //}, [daoInfo1, daoInfo2, library, tokenInfo]);

  const isValid =
    daoInfo1.daoAddress &&
    daoInfo1.daoName &&
    daoInfo1.numTokens > 0 &&
    daoInfo1.tokenAddress &&
    daoInfo2.daoAddress &&
    daoInfo2.daoName &&
    daoInfo2.numTokens > 0 &&
    daoInfo2.tokenAddress &&
    tokenInfo.tokenName &&
    tokenInfo.tokenSymbol;

  return (
    <div>
      <DaoInfo index={0} daoInfo={daoInfo1} />
      <DaoInfo index={1} daoInfo={daoInfo2} />
      <NewTokenInfo tokenInfo={tokenInfo} />

      {!contractAddress ? (
        <Button disabled={!isValid} onClick={send}>
          Create Proposal
        </Button>
      ) : (
        <div>Deployed!: {contractAddress}</div>
      )}
    </div>
  );
};
