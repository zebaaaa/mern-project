pipeline {
  agent any

  environment {
    REGION = "ap-south-1"
    ECR_REPO_URI = "329668418627.dkr.ecr.ap-south-1.amazonaws.com/mern-app"
    IMAGE_TAG = "latest"
  }

  stages {
    stage('Build & Deploy') {
      steps {
        sh 'echo Code already checked out'
        sh 'docker compose pull'
        sh 'docker compose up -d'
      }
    }
  }
}
