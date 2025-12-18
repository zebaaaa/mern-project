pipeline {
  agent any

  environment {
    REGION = "us-east-1"
    ECR_REPO_URI = "329668418627.dkr.ecr.us-east-1.amazonaws.com/mern-app"
    IMAGE_TAG = "latest"
  }

  stages {

    

    stage('Login to ECR') {
      steps {
        sh '''
        aws ecr get-login-password --region $REGION |
        docker login --username AWS --password-stdin ${ECR_REPO_URI%/*}
        '''
      }
    }

    stage('Build Backend Image') {
      steps {
        sh '''
        docker build -t mern-app:$IMAGE_TAG backend
        '''
      }
    }

    stage('Tag & Push to ECR') {
      steps {
        sh '''
        docker tag mern-app:$IMAGE_TAG $ECR_REPO_URI:$IMAGE_TAG
        docker push $ECR_REPO_URI:$IMAGE_TAG
        '''
      }
    }

    stage('Deploy using Docker Compose') {
      steps {
        sh '''
        docker compose down || true
        docker compose pull
        docker compose up -d
        '''
      }
    }
  }
}
