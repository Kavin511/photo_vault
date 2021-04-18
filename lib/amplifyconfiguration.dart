const amplifyconfig = ''' {
    "UserAgent": "aws-amplify-cli/2.0",
    "Version": "1.0",
    "auth": {
        "plugins": {
            "awsCognitoAuthPlugin": {
                "UserAgent": "aws-amplify-cli/0.1.0",
                "Version": "0.1.0",
                "IdentityManager": {
                    "Default": {}
                },
                "CredentialsProvider": {
                    "CognitoIdentity": {
                        "Default": {
                            "PoolId": "ap-south-1:4df78e21-79e7-48da-8840-67a8ac0e19ea",
                            "Region": "ap-south-1"
                        }
                    }
                },
                "CognitoUserPool": {
                    "Default": {
                        "PoolId": "ap-south-1_i6svZeJEh",
                        "AppClientId": "3p5479ou83kekb3f01an66h8vo",
                        "AppClientSecret": "YOUR_SECRET_KEY",
                        "Region": "ap-south-1"
                    }
                },
                "Auth": {
                    "Default": {
                        "authenticationFlowType": "USER_SRP_AUTH"
                    }
                },
                "AppSync": {
                    "Default": {
                        "ApiUrl": "https://xnkvhmwi2je5vhppkkwzdo224q.appsync-api.ap-south-1.amazonaws.com/graphql",
                        "Region": "ap-south-1",
                        "AuthMode": "AMAZON_COGNITO_USER_POOLS",
                        "ClientDatabasePrefix": "gallerysample_AMAZON_COGNITO_USER_POOLS"
                    }
                },
                "S3TransferUtility": {
                    "Default": {
                        "Bucket": "gallerysample909aa8135f9c4478a708dfae7be1074c104251-amplifyapp",
                        "Region": "ap-south-1"
                    }
                }
            }
        }
    },
    "api": {
        "plugins": {
            "awsAPIPlugin": {
                "gallerysample": {
                    "endpointType": "GraphQL",
                    "endpoint": "https://xnkvhmwi2je5vhppkkwzdo224q.appsync-api.ap-south-1.amazonaws.com/graphql",
                    "region": "ap-south-1",
                    "authorizationType": "AMAZON_COGNITO_USER_POOLS"
                }
            }
        }
    },
    "storage": {
        "plugins": {
            "awsS3StoragePlugin": {
                "bucket": "gallerysample909aa8135f9c4478a708dfae7be1074c104251-amplifyapp",
                "region": "ap-south-1",
                "defaultAccessLevel": "guest"
            }
        }
    }
}''';
