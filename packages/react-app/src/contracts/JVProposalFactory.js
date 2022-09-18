export const abi = [
  {
    inputs: [
      {
        components: [
          {
            internalType: "address",
            name: "treasuryAddress",
            type: "address",
          },
          {
            internalType: "address",
            name: "tokenAddress",
            type: "address",
          },
          {
            internalType: "uint256",
            name: "tokenDepositTarget",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "treasurySplit",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "poolSplit",
            type: "uint256",
          },
          {
            internalType: "uint256",
            name: "mintSplit",
            type: "uint256",
          },
        ],
        internalType: "struct IJVProposalFactory.DaoConfig[]",
        name: "_daoConfigs",
        type: "tuple[]",
      },
      {
        components: [
          {
            internalType: "string",
            name: "name",
            type: "string",
          },
          {
            internalType: "string",
            name: "symbol",
            type: "string",
          },
          {
            internalType: "address[]",
            name: "components",
            type: "address[]",
          },
          {
            internalType: "int256[]",
            name: "quantitiesPerUnit",
            type: "int256[]",
          },
        ],
        internalType: "struct IJVProposalFactory.JVTokenConfig",
        name: "_jvTokenConfig",
        type: "tuple",
      },
      {
        internalType: "uint256",
        name: "_feeTier",
        type: "uint256",
      },
    ],
    name: "createProposal",
    outputs: [
      {
        internalType: "contract IJVProposal",
        name: "",
        type: "address",
      },
    ],
    stateMutability: "nonpayable",
    type: "function",
  },
];
