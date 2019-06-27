from sklearn import linear_model
import numpy as np
from joblib import load
import boto3
from io import BytesIO

def lambda_handler(event, context):
    # import model from s3
    s3 = boto3.resource('s3')
    with BytesIO() as model:
        s3.Bucket("bobbywlindseytest").download_fileobj("regression_model.joblib", model)
        model.seek(0)    # move back to the beginning after writing
        regression_model = load(model)

    # get user input
    usr_input = event['input']

    # make predictions using the testing set
    diabetes_y_pred = regression_model.predict([[usr_input]])

    # return predictions
    return(str(diabetes_y_pred[0]))

