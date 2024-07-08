#!/bin/bash
set -eux
#assign credentials to variables
COGNITO_CLIENT_ID=<put your client id here>
USER_POOL_ID=<put your user pool id here>
USERNAME=<put a username>
PASSWORD=<put a password>
URL=<put your REST API URL here>

#sign-up user:
aws cognito-idp sign-up \
 --client-id ${COGNITO_CLIENT_ID} \
 --username ${USERNAME} \
 --password ${PASSWORD}

#confirm user:
aws cognito-idp admin-confirm-sign-up  \
  --user-pool-id ${USER_POOL_ID} \
  --username ${USERNAME}

#authenticate and get token
TOKEN=$(
    aws cognito-idp initiate-auth \
 --client-id ${COGNITO_CLIENT_ID} \
 --auth-flow USER_PASSWORD_AUTH \
 --auth-parameters USERNAME=${USERNAME},PASSWORD=${PASSWORD} \
 --query 'AuthenticationResult.IdToken' \
 --output text
    )
#make API call:
curl -H "Authorization: ${TOKEN}" ${URL}