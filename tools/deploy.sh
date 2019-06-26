#!/bin/bash

# make a scikit-learn zip to be added as a layer
cd layers/sklearn
docker run --rm -v $PWD:/var/task lambci/lambda:build-python3.7 \
pip install scikit-learn --no-deps -t python/lib/python3.7/site-packages/
zip -r9q sklearn-layer.zip .
# upload it to s3
echo "Uploading sklearn layer to s3..."
aws s3 cp sklearn-layer.zip s3://bobbywlindseytest
# cleanup
rm -f sklearn-layer.zip
rm -rf python/
cd ../..

# make a joblib zip to be added as a layer
cd layers/joblib
docker run --rm -v $PWD:/var/task lambci/lambda:build-python3.7 \
pip install joblib --no-deps -t python/lib/python3.7/site-packages/
zip -r9q joblib-layer.zip .
# upload it to s3
echo "Uploading joblib layer to s3..."
aws s3 cp joblib-layer.zip s3://bobbywlindseytest
# cleanup
rm -f joblib-layer.zip
rm -rf python/
cd ../..

# zip the python lambda code
echo "Zipping the code..."
cd src/
zip function.zip function.py
# upload it to s3
echo "Uploading code to s3..."
aws s3 cp function.zip s3://bobbywlindseytest
# cleanup
echo "Removing zip file..."
rm -f function.zip

echo "Deploying stack..."
aws cloudformation deploy --template-file ../infrastructure/cloudformation.json --stack-name my-test-stack