pipeline {

    agent any

    environment {
        PROJECT_DIR = "/home/ubuntu/LoanWise-Predictive-Loan-Approval"
    }

    stages {

        stage('Checkout') {
            steps {
                git branch: 'main',
                    credentialsId: 'github-account',
                    url: 'https://github.com/YOUR_USERNAME/LoanWise-Predictive-Loan-Approval.git'
            }
        }

        stage('Copy Project') {
            steps {
                sh '''
                    sudo rm -rf ${PROJECT_DIR}
                    sudo mkdir -p ${PROJECT_DIR}
                    sudo cp -r ${WORKSPACE}/. ${PROJECT_DIR}/
                    sudo chown -R jenkins:jenkins ${PROJECT_DIR}
                '''
            }
        }

        stage('Stop Old Containers') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}
                    docker compose down || true
                '''
            }
        }

        stage('Build') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}
                    docker compose build
                '''
            }
        }

        stage('Deploy') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}
                    docker compose up -d
                '''
            }
        }

        stage('Check') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}
                    docker compose ps
                '''
            }
        }

        stage('Health Check') {
            steps {
                sh '''
                    sleep 10
                    curl -f http://localhost:8000/health
                    curl -f http://localhost/
                '''
            }
        }
    }

    post {

        success {
            echo 'LoanWise deployment successful!'
        }

        failure {
            echo 'LoanWise deployment failed!'
        }
    }
}
