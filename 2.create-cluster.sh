#!/bin/bash

export clusterInfo=`az group deployment create --name ${kubeGroup}-deployment --resource-group ${kubeGroup} --template-file "./acs-engine/_output/${dnsPrefix}/azuredeploy.json" --parameters "./acs-engine/_output/${dnsPrefix}/azuredeploy.parameters.json"`
echo $clusterInfo > ./acs-engine/_output/cluster-info.json
export masterHost=`echo $clusterInfo | jq ".properties.outputs.masterFQDN.value" -r`
scp azureuser@${masterHost}:.kube/config ~/.kube/${dnsPrefix}
export KUBECONFIG=$KUBECONFIG:~/.kube/${dnsPrefix}
