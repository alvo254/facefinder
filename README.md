# Serverless Image Recognition with Amazon Rekognition

Using aws to detect faces in an image 

## Challange 11

Welcome to my solution documentation! In this project, we will explore the combination of serverless computing and machine learning services provided by Amazon Web Services (AWS). Specifically, we will leverage AWS Lambda for serverless computing and Amazon Rekognition for image recognition capabilities.

## Introduction

A serverless service does not eliminate the need for servers to run your apps; rather, it allows you to delegate server management to AWS, enabling you to focus on development without worrying about server provisioning and maintenance. Amazon Rekognition is a powerful machine learning service offered by AWS, which we'll use to detect faces in uploaded images.

## Brief Explanation

The project involves creating an AWS Lambda function that is triggered when an image is uploaded to an S3 bucket. The Lambda function will use Amazon Rekognition to detect faces in the uploaded image. If one or more faces are detected, the Lambda function will store the relevant information (e.g., image key, face details) in an Amazon DynamoDB table. Additionally, if a face is detected, the Lambda function will trigger an Amazon SNS topic to send an email notification.
The Lambda function will be packaged with the necessary dependencies, and its execution role will be configured with the required permissions to interact with the S3 bucket, Rekognition, DynamoDB, and SNS services.
The project will be organized into separate Terraform modules for better maintainability and reusability. These modules include:

S3 Module: Responsible for creating the S3 bucket and configuring event notifications to trigger the Lambda function.
Lambda Module: Responsible for creating the Lambda function, its execution role, and necessary permissions.
DynamoDB Module: Responsible for creating the DynamoDB table to store face information.
VPC Module: Responsible for creating the VPC, subnets, and security groups required for the Lambda function to run within a VPC.
Security Group Module: Responsible for creating the security group rules to control inbound and outbound traffic for the Lambda function.
EventBridge Module: Responsible for creating the EventBridge rule and configuring it to trigger the Lambda function when an image is uploaded to the S3 bucket.

By leveraging AWS serverless services and Terraform for infrastructure provisioning, this project demonstrates a scalable and event-driven architecture for face detection and notification use cases.

## Objectives

Create an Amazon S3 bucket with event notifications to trigger a Lambda function.
Utilize Amazon Rekognition to detect faces in uploaded images.
Populate a DynamoDB table with information about detected faces.
Trigger Amazon SNS to send email notifications if an image contains a face.

