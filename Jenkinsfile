pipeline {
    agent { label 'vm2-agent' } // pour forcer l’agent VM2

    environment {
        DOCKER_IMAGE = 'ecommerce-app:latest'
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
                script {
                    sh 'docker build -t $DOCKER_IMAGE .'
                }
            }
        }

        stage('Run Docker Container (optionnel)') {
            steps {
                script {
                    // on arrête le container précédent s’il existe
                    sh 'docker rm -f ecommerce-container || true'
                    // on lance le container
                    sh 'docker run -d --name ecommerce-container -p 8080:8080 $DOCKER_IMAGE'
                }
            }
        }
    }

    post {
        success {
            echo '✅ Pipeline terminé avec succès.'
        }
        failure {
            echo '❌ Pipeline échoué.'
        }
    }
}

