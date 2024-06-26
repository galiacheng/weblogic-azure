#!/bin/bash
# Copyright (c) 2021, Oracle and/or its affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl.

#Generate parameters with value for deploying db template independently

#read arguments from stdin
read parametersPath adminVMName dbPassword dbAdminUser dbName location wlsusername wlspassword repoPath testbranchName

cat <<EOF > ${parametersPath}/parameters-deploy-db.json
{
     "adminVMName":{
        "value": "${adminVMName}"
      },
      "databaseType": {
        "value": "postgresql"
      },
      "dbPassword": {
        "value": "${dbPassword}"
      },
      "dbUser": {
        "value": "${dbAdminUser}"
      },
      "dsConnectionURL": {
        "value": "jdbc:postgresql://${dbName}.postgres.database.azure.com:5432/postgres?sslmode=require"
      },
      "jdbcDataSourceName": {
        "value": "jdbc/WebLogicDB"
      },
      "location": {
        "value": "${location}"
      },
      "wlsPassword": {
        "value": "${wlsPassword}"
      },
      "wlsUserName": {
        "value": "${wlsUserName}"
      },
      "_artifactsLocation":{
        "value": "https://raw.githubusercontent.com/${repoPath}/${testbranchName}/weblogic-azure-vm/arm-oraclelinux-wls-admin/src/main/arm/"
      },
    }
EOF
