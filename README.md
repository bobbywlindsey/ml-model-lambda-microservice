# ml-model-lambda-microservice

How to deploy a simple scikit-learn model using a Python lambda function with API Gatweay configuration via CloudFormation.

To deploy, run:

`./tools/deploy.sh`

Use the AWS Console to get the physicsal ID of `apiGateway` that was randomly generated by AWS. Then test the endpoint with the following Python code:

```python
import requests

url = "[apiGateway physical ID].execute-api.us-east-1.amazonaws.com/TestStageName"
input_data = {
    "input": 0.6
}

r = requests.post(url, json=input_data)
print(r.json())
```

To delete all resources you created in AWS (except for the S3 uploads), run:

`./tools/tear-down.sh`

