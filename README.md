# Jenkins-terraform-playground
Jenkins Terraform playground

## TestJenkinsTFs3LambdaAPIGateway

Project creates via Jenkinsfile using terraform:
- Lambda function that lists all files in s3 bucket presented hierachically
- Trigger for Lambda: any addition to the s3
- API gateway to display results as well on-demand : https://kiouc28cah.execute-api.us-east-1.amazonaws.com/s3-list

## TestDockerServiceK8s

Project creates via Jenkins:
- dockerized Python app uploaded to docker.com
- a K8s service and app on EKS