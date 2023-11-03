# docker-app-CI-CD 
Full CI/CD App with Terraform, AWS, Docker, Jenkins, and Node.js 

![Static Badge](https://img.shields.io/badge/completed-green)

## Table of Contents

- [Description](#description)
- [Key Features](#key-features)
- [Getting Started](#getting-started)

## Description

This GitHub repository is a demonstration of a CI/CD pipeline for a Node.js application, showcasing the seamless integration of Docker, Jenkins, and Node.js technologies. The project provides a complete DevOps workflow to automate the build, test, and deployment processes, making it easy to maintain and release your Node.js applications efficiently.

## Key Features

- **Dockerized Environment:** The project includes Docker containers to create a consistent and isolated environment for your Node.js application, ensuring that it runs smoothly across different platforms.

- **Jenkins Pipeline:** An elaborative Jenkins pipeline is defined to automate the CI/CD process. It covers stages like code compilation, testing, and deployment to various environments.

- **Node.js Application:** The repository contains a sample Node.js application that serves as the target for CI/CD. You can easily replace it with your own Node.js projects.

- **Testing Framework:** We've integrated a testing framework (e.g., Mocha, Jest) to run tests as part of the CI process, ensuring the quality and reliability of your code.

- **Deployment Strategies:** The project illustrates multiple deployment strategies, including blue-green deployment and rolling deployment, to efficiently release new versions of your application.

- **Infrastructure as Code:** Infrastructure is defined as code using tools like Docker Compose or Kubernetes, making it easy to scale and manage your application in a containerized environment.

## Getting Started


Follow these simple steps to set up Jenkins using Terraform for automated pipeline deployments:

### Step 1: Initialize Terraform

```bash
terraform init
```

This command initializes your Terraform environment and prepares it for further configuration.

### Step 2: Create a Terraform Plan

```bash
terraform plan
```

Generate a Terraform plan to review the changes that will be made during the setup.

### Step 3: Apply the Configuration

```bash
terraform apply -y
```

Apply the configuration to create the necessary resources on your cloud provider. The `-y` flag will automatically approve the changes.

### Step 4: Configure Jenkins

1. Access your EC2 instance created by Terraform.
2. Log in to your Jenkins account.
3. Configure the Jenkins pipeline using the "jenkins_pipeline.groovy" script.

### Step 4.1: Set Up GitHub Webhook (in Jenkins)

To enable automated pipeline triggers from your GitHub repository, configure a webhook:

1. In your GitHub repository, navigate to "Settings" > "Webhooks."
2. Click "Add webhook" and provide the necessary details.
3. Set the Payload URL to your Jenkins server webhook endpoint.
4. Choose the events you want to trigger the webhook.
5. Save the webhook configuration.

### Step 4.2: Configure Docker Credentials (in Jenkins)

1. In Jenkins, navigate to "Manage Jenkins" > "Manage Credentials."
2. Click "Global credentials."
3. Add Docker credentials for your registry or container repository.

Your Jenkins setup is now ready to automate your CI/CD pipeline. Happy coding! 🚀

Feel free to modify and expand upon this README as needed for your specific project.
