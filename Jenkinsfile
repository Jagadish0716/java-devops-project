pipeline {
  agent { 
    label 'docker-server' 
  }

  environment {
    APP_NAME = 'ecommerce-app'
    DOCKERHUB_REPO = 'jagadish1607/eduwise-ecommerce'
    IMAGE_TAG = "${env.BUILD_NUMBER}"
    IMAGE_NAME = "${DOCKERHUB_REPO}:${IMAGE_TAG}"
    STACK_NAME = 'ecommerce'
    SERVICE_NAME = 'ecommerce_web'
  }

  triggers {
    githubPush()
  }

  tools {
    maven 'Maven-3'
    //jdk 'JDK-17' - commentde bcz jdk-21 is already insatlled in node
  }

  stages {
    stage('Checkout') {
      steps {
        checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Jagadish0716/eduwise-ecommerce.git']])
      }
    }

    stage('Maven Build') {
      steps {
        sh 'mvn clean package'
      }
      post {
        success {
          archiveArtifacts artifacts: 'target/*.war', fingerprint: true
        }
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t ${IMAGE_NAME} .'
        sh 'docker tag ${IMAGE_NAME} ${DOCKERHUB_REPO}:latest'
      }
    }

    stage('Push To Docker Hub') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
          sh 'echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin'
          sh 'docker push ${IMAGE_NAME}'
          sh 'docker push ${DOCKERHUB_REPO}:latest'
        }
      }
    }

    stage('Deploy To Docker Swarm') {
      steps {
        sh 'docker stack deploy -c docker-stack.yml ${STACK_NAME}'
        sh 'docker service update --image ${IMAGE_NAME} --with-registry-auth ${SERVICE_NAME}'
        sh 'docker service scale ${SERVICE_NAME}=3'
      }
    }

    stage('Verify Deployment') {
      steps {
        sh 'docker service ls'
        sh 'docker service ps ${SERVICE_NAME} --no-trunc'
      }
    }
  }

  post {
    failure {
      echo 'Deployment failed. Rolling back to previous Swarm service version.'
      sh 'docker service rollback ${SERVICE_NAME} || true'
      sh 'docker service ps ${SERVICE_NAME} --no-trunc || true'
    }
    always {
      sh 'docker logout || true'
    }
  }
}
