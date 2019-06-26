#!/bin/bash

# remove the file if it exists
echo "Removing zip file if exists..."
rm -f ./src/function.zip


# then zip the code
echo "Zipping the code..."
cd src/
zip function.zip function.py

# now upload zip of lambda function using cli
# since CloudFormation doesn't have access
# to file system
echo "Uploading code to s3..."
aws s3 cp *.zip s3://bobbywlindseytest

# remove the zip file
echo "Removing zip file..."
rm -f function.zip

echo "Deploying stack..."
aws cloudformation deploy --template-file ../infrastructure/cloudformation.json --stack-name my-test-stack