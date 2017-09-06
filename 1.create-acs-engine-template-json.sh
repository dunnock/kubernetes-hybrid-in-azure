#!/bin/bash

echo $dnsPrefix
export SUBSCRIPTION_ID=`az account show | jq ".id" -r`
export res1=`az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/${SUBSCRIPTION_ID}"`
export spName=$(echo $res1 | jq ".appId" -r)
export spPassword=$(echo $res1 | jq ".password" -r)
rm -rf acs-engine/_output
export linuxKeyData=$(< ~/.ssh/id_rsa.pub)
export windowsPassword='ReplaceWithSecurePassword1234'
mkdir acs-engine/_output
jq <acs-engine/examples/windows/kubernetes-hybrid.json ".properties.servicePrincipalProfile.clientId=\"$spName\" | .properties.servicePrincipalProfile.secret=\"$spPassword\" | .properties.linuxProfile.ssh.publicKeys[0].keyData=\"$linuxKeyData\" | .properties.windowsProfile.adminPassword=\"$windowsPassword\" | .properties.masterProfile.dnsPrefix=\"$dnsPrefix\"" >acs-engine/_output/demo-kubernetes-hybrid.json