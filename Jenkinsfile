pipeline {
    agent any

    environment {
        DOCKER_IMAGE = "ecommerce-app"
        DOCKER_TAG = "latest"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/Mohaa922/e-commerce-app.git'
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package -DskipTests'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} ."
            }
        }

        stage('Push Docker Image (optionnel)') {
            when {
                expression { return env.DOCKER_HUB_USERNAME != null }
            }
            steps {
                withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_HUB_PASSWORD')]) {
                    sh "echo $DOCKER_HUB_PASSWORD | docker login -u ${DOCKER_HUB_USERNAME} --password-stdin"
                    sh "docker tag ${DOCKER_IMAGE}:${DOCKER_TAG} ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                    sh "docker push ${DOCKER_HUB_USERNAME}/${DOCKER_IMAGE}:${DOCKER_TAG}"
                }
            }
        }

        stage('Deploy (optionnel)') {
            steps {
                echo 'Déploiement à définir…'
            }
        }
    }

    post {
        success {
            echo 'Pipeline terminé avec succès 🎉'
        }
        failure {
            echo 'Pipeline échoué ❌'
        }
    }
}
