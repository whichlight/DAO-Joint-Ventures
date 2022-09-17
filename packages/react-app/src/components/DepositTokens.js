import { useParams } from 'react-router-dom';

export const DepositTokens = () => {
  const { proposalId } = useParams();
  return (
    <div>
      <h2>Proposal {proposalId}</h2>
    </div>
  );
};
