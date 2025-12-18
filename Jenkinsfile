pipeline {
  agent any

  environment {
    IMAGE = "tg/todo-app:ci"
    COMPOSE_DIR = "docker"
    COMPOSE_FILE = "docker-compose_NurasylMaratkanuly.yml"
    ENV_FILE = ".env"
  }

  stages {
    stage('Checkout') {
      steps { checkout scm }
    }

    stage('Build JAR (Gradle)') {
      steps {
        dir('app/todo-app/todo-app') {
          sh '''
            set -eux
            ./gradlew --no-daemon clean build -x test
            ls -la build/libs
          '''
        }
      }
    }

    stage('Build Docker image') {
      steps {
        sh '''
          set -eux
          docker build -t ${IMAGE} -f docker/Dockerfile_NurasylMaratkanuly .
          docker images | head
        '''
      }
    }

    stage('Prepare .env for Compose') {
      steps {
        dir("${COMPOSE_DIR}") {
          sh '''
            set -eux
            if [ ! -f "${ENV_FILE}" ]; then
              if [ -f ".env.example" ]; then
                cp .env.example "${ENV_FILE}"
              else
                cat > "${ENV_FILE}" <<'EOF'
POSTGRES_DB=todo_db
POSTGRES_USER=todo_user
POSTGRES_PASSWORD=todo_pass
SPRING_DATASOURCE_URL=jdbc:postgresql://pg_todo:5432/todo_db
SPRING_DATASOURCE_USERNAME=todo_user
SPRING_DATASOURCE_PASSWORD=todo_pass
EOF
              fi
            fi
            echo "== .env prepared =="
            ls -la "${ENV_FILE}"
          '''
        }
      }
    }

    stage('Run via Docker Compose') {
      steps {
        dir("${COMPOSE_DIR}") {
          sh '''
            set -eux
            docker compose -f ${COMPOSE_FILE} --env-file ${ENV_FILE} up -d
            docker compose -f ${COMPOSE_FILE} ps
          '''
        }
        sh 'curl -s http://localhost:8080/actuator/health || true'
      }
    }
  }

  post {
    always {
      sh '''
        docker ps --format "table {{.Names}}\\t{{.Status}}\\t{{.Ports}}" || true
      '''
      dir("${COMPOSE_DIR}") {
        sh '''
          docker compose -f ${COMPOSE_FILE} ps || true
        '''
      }
    }
  }
}
