#!/bin/bash

# Importing useful functions for cc testing
if [ -f ./func.sh ]; then
 source ./func.sh
elif [ -f scripts/func.sh ]; then
 source scripts/func.sh
fi

#Upgrade to new version
echo_b "Upgrade chaincode to new version..."
chaincodeInstall 1 0 ${CC_NAME} ${CC_UPGRADE_VERSION} ${CC_PATH}
chaincodeInstall 1 1 ${CC_NAME} ${CC_UPGRADE_VERSION} ${CC_PATH}
chaincodeInstall 2 0 ${CC_NAME} ${CC_UPGRADE_VERSION} ${CC_PATH}
chaincodeInstall 2 1 ${CC_NAME} ${CC_UPGRADE_VERSION} ${CC_PATH}

# Upgrade on one peer of the channel will update all
chaincodeUpgrade ${CHANNEL_NAME} 1 0 ${CC_NAME} ${CC_UPGRADE_VERSION} ${CC_UPGRADE_ARGS}

# Query new value, should refresh through all peers in the channel
chaincodeQuery ${CHANNEL_NAME} 1 0 ${CC_NAME} ${CC_QUERY_ARGS} 100
chaincodeQuery ${CHANNEL_NAME} 2 1 ${CC_NAME} ${CC_QUERY_ARGS} 100

echo_g "=== All GOOD, chaincode Upgrade completed ==="
