# Serverless Image Recognition with Amazon Rekognition

Using aws to detect faces in an image 

## Challange 11

Welcome to my solution documentation! In this project, we will explore the combination of serverless computing and machine learning services provided by Amazon Web Services (AWS). Specifically, we will leverage AWS Lambda for serverless computing and Amazon Rekognition for image recognition capabilities.

## Introduction

A serverless service does not eliminate the need for servers to run your apps; rather, it allows you to delegate server management to AWS, enabling you to focus on development without worrying about server provisioning and maintenance. Amazon Rekognition is a powerful machine learning service offered by AWS, which we'll use to detect faces in uploaded images.

## Objectives

Create an Amazon S3 bucket with event notifications to trigger a Lambda function.
Utilize Amazon Rekognition to detect faces in uploaded images.
Populate a DynamoDB table with information about detected faces.
Trigger Amazon SNS to send email notifications if an image contains a face.

