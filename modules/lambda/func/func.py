import os
import json
import boto3
import logging

# Setup logging
logger = logging.getLogger()
logger.setLevel(logging.DEBUG)
bucket_name = os.environ.get("FACE_FINDER_BUCKET_NAME")

def lambda_handler(event, context):
    try:
        # Initialize the Rekognition client
        rekognition = boto3.client('rekognition')
        
        # Initialize the DynamoDB client
        dynamodb = boto3.client('dynamodb')
        
        logger.info("Received event: %s", json.dumps(event))
        
        # Extract bucket name and object key from the event
        records = event.get('Records', [])
        if not records:
            logger.error("No records found in the event.")
            return {
                'statusCode': 400,
                'body': json.dumps('No records found in the event.')
            }
        
        record = records[0]  # Assuming only one record is processed at a time
        s3 = record.get('s3', {})
        bucket_name = s3.get('bucket', {}).get('name', '')
        object_key = s3.get('object', {}).get('key', '')
        
        if not bucket_name or not object_key:
            logger.error("Bucket name or object key not found in the event.")
            return {
                'statusCode': 400,
                'body': json.dumps('Bucket name or object key not found in the event.')
            }
        
        logger.info("Processing object: s3://%s/%s", bucket_name, object_key)
        
        # Detect faces in the uploaded photo using Rekognition
        response = rekognition.detect_faces(
            Image={
                'S3Object': {
                    'Bucket': bucket_name,
                    'Name': object_key
                }
            }
        )
        
        # Extract information about detected faces
        face_details = []
        for face in response.get('FaceDetails', []):
            face_info = {
                'BoundingBox': face.get('BoundingBox', {}),
                'Confidence': face.get('Confidence', 0.0)
                # Add more attributes as needed
            }
            face_details.append(face_info)
        
        # Store information about detected faces in DynamoDB
        if face_details:
            dynamodb.put_item(
                TableName='FaceImages',
                Item={
                    'BucketName': {'S': bucket_name},
                    'ObjectKey': {'S': object_key},
                    'FaceDetails': {'L': [{'M': face} for face in face_details]}
                }
            )
        
        logger.info("Processing completed successfully.")
        
        return {
            'statusCode': 200,
            'body': json.dumps('Photo analysis and storage completed successfully!')
        }
    except Exception as e:
        logger.exception("An error occurred: %s", str(e))
        return {
            'statusCode': 500,
            'body': json.dumps('An error occurred during processing.')
        }

