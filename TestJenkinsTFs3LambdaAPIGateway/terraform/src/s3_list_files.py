import json
import logging
from boto3 import resource
from collections import defaultdict

logger = logging.getLogger()
logger.setLevel(logging.INFO)


def construct_dict(in_list, accumulator):
    try:
        if not in_list:
            return
        else:
            if in_list[0] not in accumulator:
                accumulator[in_list[0]] = defaultdict(list)
            return construct_dict(in_list[1::], accumulator[in_list[0]])

    except Exception as e:
        logger.info(f'Error: Unable to Construct dictionary: {e}')


def lambda_handler(event, context):

    try:
        global s3_resource
        s3_resource = resource('s3')
        source_bucket = s3_resource.Bucket('mf-test-lambda')
        accumulator = defaultdict(list)
        for bucket_object in source_bucket.objects.all():
            construct_dict(bucket_object.key.split('/'), accumulator)

        return {
            'statusCode': 200,
            'headers': {'Content-Type': 'text/html; charset=utf-8'},
            'body': json.dumps(accumulator)
        }

    except Exception as e:
        logger.info(f'Error: Unable run hndler: {e}')
