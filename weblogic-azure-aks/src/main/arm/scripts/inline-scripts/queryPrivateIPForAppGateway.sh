# Copyright (c) 2022, Oracle Corporation and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.
# This script runs on Azure Container Instance with Alpine Linux that Azure Deployment script creates.
#
# env inputs:
# SUBNET_ID
# KNOWN_IP

function query_ip() {
    echo_stdout "Subnet Id: ${SUBNET_ID}"

    # select a available private IP
    # output looks like: [ "172.16.0.4", "172.16.0.5", "172.16.0.6", "172.16.0.7", "172.16.0.8" ]
    local ret=$(az network vnet subnet list-available-ips --ids ${SUBNET_ID})
    local length=$(echo ${ret} | jq length)

    if [[ "$length" =~ ^[0-9]+$ ]] && [ "$length" -gt 0 ]; then
      outputPrivateIP=$(echo ${ret} | jq -r '.[0]')
    else
      echo_stderr "ERROR: make sure there is available IP for application gateway in your subnet."
    fi    
}

function output_result() {
  echo "Available Private IP: ${outputPrivateIP}"
  result=$(jq -n -c \
    --arg privateIP "$outputPrivateIP" \
    '{privateIP: $privateIP}')
  echo "result is: $result"
  echo $result >$AZ_SCRIPTS_OUTPUT_PATH
}

# main script
outputPrivateIP=${KNOWN_IP}

query_ip

output_result