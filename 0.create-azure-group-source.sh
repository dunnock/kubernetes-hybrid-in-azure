#!/bin/bash

export kubeGroup='kube-demo-1'
export dnsPrefix='kube-demo-kiev-1'
az group create --name $kubeGroup --location eastus