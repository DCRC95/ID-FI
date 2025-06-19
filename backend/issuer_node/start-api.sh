#!/bin/bash

# Start the issuer node API
echo "Starting Issuer Node API..."

# Create a temporary resolvers settings file with proper paths
cat > /tmp/resolvers_settings.yaml << 'EOF'
polygon:
  amoy:
    contractAddress: 0x1a4cC30f2aA0377b0c3bc9848766D90cb4404124
    networkURL: https://polygon-mumbai.g.alchemy.com/v2/demo
    defaultGasLimit: 600000
    confirmationTimeout: 10s
    confirmationBlockCount: 5
    receiptTimeout: 600s
    minGasPrice: 0
    maxGasPrice: 1000000
    rpcResponseTimeout: 5s
    waitReceiptCycleTime: 30s
    waitBlockCycleTime: 30s
    gasLess: false
    rhsSettings:
      mode: None
      contractAddress: 0x7dF78ED37d0B39Ffb6d4D527Bb1865Bf85B60f81
      rhsUrl: https://rhs-staging.polygonid.me
      chainID: 80002
      publishingKey: pbkey
EOF

# Run the API container
docker run -d \
  --name issuer-api \
  --network issuer-network \
  -p 3001:3001 \
  -v /tmp/resolvers_settings.yaml:/service/resolvers_settings.yaml \
  -e ISSUER_SERVER_URL=http://localhost:3001 \
  -e ISSUER_API_AUTH_USER=user-issuer \
  -e ISSUER_API_AUTH_PASSWORD=password-issuer \
  issuernode-api:local

echo "API started on http://localhost:3001"
echo "Username: user-issuer"
echo "Password: password-issuer" 