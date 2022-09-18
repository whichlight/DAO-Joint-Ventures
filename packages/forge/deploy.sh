echo 'deploying FOO token ...'
forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80  --rpc-url http://localhost:8545 MockERC20 --constructor-args "FooDAO Token" "FOO" 18 | grep "Deployed to"

echo 'deploying BAR token ...'
forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80  --rpc-url http://localhost:8545 MockERC20 --constructor-args "BarDAO Token" "BAR" 18 | grep "Deployed to"

echo 'deploying JVProposalFactory ...'
forge create --private-key 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80  --rpc-url http://localhost:8545 JVProposalFactory | grep "Deployed to"