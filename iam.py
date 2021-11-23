import boto3
from datetime import datetime, timedelta

client = boto3.client('iam')
users = client.list_users()

for key in users['Users']:
    username = key['UserName']
    # List access keys through the pagination interface.
    paginator = client.get_paginator('list_access_keys')

    for response in paginator.paginate(UserName=username):
        accessKeyMetadata = response['AccessKeyMetadata']

        # Check if user has some keys, if not continue with next user in the list
        if len(accessKeyMetadata) != 0:
            accessKeyId = accessKeyMetadata[0]['AccessKeyId']
            accessKeyLastUsedResponse = client.get_access_key_last_used(AccessKeyId=accessKeyId)
            accessKeyLastUsed = accessKeyLastUsedResponse['AccessKeyLastUsed']
            lastUsedDate = accessKeyLastUsed['LastUsedDate']
            lastActivity = datetime.now(lastUsedDate.tzinfo) - lastUsedDate

        accessKeyCreationDate = accessKeyMetadata[0]['CreateDate']
        accessKeyAge = datetime.now(accessKeyCreationDate.tzinfo) - accessKeyCreationDate