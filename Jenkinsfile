pipeline {
  agent any

  environment {
    IMAGE = "tg/todo-app:ci"
    COMPOSE_FILE = "docker/docker-compose_NurasylMaratkanuly.yml"
    ENV_FILE = "docker/.env"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build JAR (Gradle)') {
      steps {
        dir('app/todo-app/todo-app') {
          sh './gradlew clean build -x test'
          sh 'ls -la build/libs'
        }
      }
    }

    stage('Build Docker image') {
      steps {
        sh 'docker build -t ${IMAGE} -f docker/Dockerfile_NurasylMaratkanuly .'
        sh 'docker images | head'
      }
    }

    stage('Run via Docker Compose') {
      steps {
        dir('docker') {
          sh 'docker compose -f docker-compose_NurasylMaratkanuly.yml --env-file .env up -d'
          sh 'docker compose -f docker-compose_NurasylMaratkanuly.yml ps'
        }
        sh 'curl -s http://localhost:8080/actuator/health || true'
      }
    }
  }

  post {
    always {
      sh 'docker ps --format "table {{.Names}}\\t{{.Status}}\\t{{.Ports}}" || true'
    }
  }
}
