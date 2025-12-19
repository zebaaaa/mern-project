pipeline {
  agent any

  environment {
    REGION = "ap-south-1"
    ECR_REGISTRY = "329668418627.dkr.ecr.ap-south-1.amazonaws.com"
  }

  stages {

    stage("Checkout Code") {
      steps {
        git branch: 'main', url: 'https://github.com/zebaaaa/mern-app.git'
      }
    }

    stage("Login to ECR") {
      steps {
        sh '''
        aws ecr get-login-password --region $REGION |
        docker login --username AWS --password-stdin $ECR_REGISTRY
        '''
      }
    }

    stage("Deploy Containers") {
      steps {
        sh '''
        docker compose pull
        docker compose up -d
        '''
      }
    }
  }
}
