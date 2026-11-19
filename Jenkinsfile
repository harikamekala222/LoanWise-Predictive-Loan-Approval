pipeline {

    agent any

    environment {
        PROJECT_DIR = '/home/ubuntu/LoanWise-Predictive-Loan-Approval'
    }

    stages {

        stage('Checkout') {
            steps {
                echo 'Checking out source code...'

                git branch: 'main',
                    credentialsId: 'github-account',
                    url: 'https://github.com/YOUR_USERNAME/LoanWise-Predictive-Loan-Approval.git'
            }
        }

        stage('Check Docker') {
            steps {
                sh '''
                    echo "Checking Docker..."
                    docker --version

                    echo "Checking Docker Compose..."
                    docker compose version

                    echo "Docker containers:"
                    docker ps
                '''
            }
        }

        stage('Copy Project') {
            steps {
                sh '''
                    echo "Copying project to deployment directory..."

                    sudo rm -rf ${PROJECT_DIR}

                    sudo mkdir -p ${PROJECT_DIR}

                    sudo cp -r ${WORKSPACE}/. ${PROJECT_DIR}/

                    sudo chown -R ubuntu:ubuntu ${PROJECT_DIR}

                    sudo setfacl -R -m u:jenkins:rwx ${PROJECT_DIR}
                '''
            }
        }

        stage('Stop Old Containers') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}

                    echo "Stopping old LoanWise containers..."

                    docker compose down || true
                '''
            }
        }

        stage('Build Images') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}

                    echo "Building LoanWise images..."

                    docker compose build --no-cache
                '''
            }
        }

        stage('Start Application') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}

                    echo "Starting LoanWise..."

                    docker compose up -d
                '''
            }
        }

        stage('Check Containers') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}

                    echo "Checking running containers..."

                    docker compose ps
                '''
            }
        }

        stage('Backend Health Check') {
            steps {
                sh '''
                    echo "Waiting for backend..."

                    sleep 15

                    curl -f http://localhost:8000/health

                    echo ""
                    echo "Backend health check successful."
                '''
            }
        }

        stage('Frontend Check') {
            steps {
                sh '''
                    echo "Checking frontend..."

                    curl -I -f http://localhost/

                    echo ""
                    echo "Frontend check successful."
                '''
            }
        }

        stage('Show Logs') {
            steps {
                sh '''
                    cd ${PROJECT_DIR}

                    echo "===== Docker Compose Status ====="
                    docker compose ps

                    echo "===== Backend Logs ====="
                    docker logs loanwise-backend --tail 30

                    echo "===== Frontend Logs ====="
                    docker logs loanwise-frontend --tail 20

                    echo "===== MySQL Logs ====="
                    docker logs loanwise-mysql --tail 20
                '''
            }
        }
    }

    post {

        success {
            echo '''
            ==========================================
              LoanWise Deployment Successful
            ==========================================
            '''
        }

        failure {
            echo '''
            ==========================================
              LoanWise Deployment Failed
            ==========================================
            '''
        }

        always {
            echo 'Jenkins pipeline completed.'
        }
    }
}
