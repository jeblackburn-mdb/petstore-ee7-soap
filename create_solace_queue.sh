#!/usr/bin/env bash
set -ex

echo "Creating a Queue first on default messageVPN"

curl http://localhost:8081/SEMP/v2/config/msgVpns/default/queues \
  -X POST \
  -u admin:admin \
  -H "Content-type:application/json" \
  -d '{ "queueName":"petstorequeue",
      "accessType":"exclusive",
      "maxMsgSpoolUsage":200,
      "permission":"consume",
      "ingressEnabled":true,
      "egressEnabled":true }'
      
echo "Creating a subscriptions in that queue"

curl http://localhost:8081/SEMP/v2/config/msgVpns/default/queues/petstorequeue/subscriptions \
  -X POST \
  -u admin:admin \
  -H "Content-type:application/json" \
  -d '{ "subscriptionTopic":"petstore/*" }'

echo "Done creating Solace queue and subscription"