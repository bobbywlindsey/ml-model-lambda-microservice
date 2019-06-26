# deploy-lambda-function

How to deploy a simple Python lambda function with API Gatweay configuration via CloudFormation

To deploy, run:

`./tools/deploy.sh`

To tear down, run:

`./tools/tear-down.sh`

```
cd layers/sklearn
docker run --rm -it -v $PWD:/var/task lambci/lambda:build-python3.7 bash
pip install scikit-learn --no-deps -t python/lib/python3.7/site-packages/
exit
zip -r9q sklearn-layer.zip .

cd layers/sklearn
docker run --rm -it -v $PWD:/var/task lambci/lambda:build-python3.7 bash
pip install joblib --no-deps -t python/lib/python3.7/site-packages/
exit

```
