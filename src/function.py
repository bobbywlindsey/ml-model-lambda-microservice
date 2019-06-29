from sklearn import linear_model
import numpy as np
from joblib import load
import boto3
from io import BytesIO
import json

def response(message, status_code):
    return {
        'statusCode': str(status_code),
        'body': json.dumps(message),
        'headers': {
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*'
        },
    }

def lambda_handler(event, context):
    # import model from s3
    s3 = boto3.resource('s3')
    with BytesIO() as model:
        s3.Bucket("bobbywlindseytest").download_fileobj("regression_model.joblib", model)
        model.seek(0) # move back to the beginning after writing
        regression_model = load(model)

    # get user input
    request_body = event['body']
    # if request came from api gateway
    if isinstance(event['body'], (str)):
        request_body = json.loads(request_body)
    usr_input = request_body['input']

    # make predictions using the testing set
    diabetes_y_pred = regression_model.predict([[usr_input]])

    # return predictions
    return response({'prediction': diabetes_y_pred[0]}, 200)