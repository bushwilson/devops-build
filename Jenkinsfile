pipeline {
    agent any

    options {
        disableConcurrentBuilds()
    }

    environment {
        DOCKER_USER = 'bushwilson'
        TARGET = "${env.BRANCH_NAME == 'main' ? 'prod' : 'dev'}"
    }

    stages {
        stage('Build Image') {
            steps {
                sh "./build.sh ${TARGET}"
            }
        }

        stage('Push Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DH_USER', passwordVariable: 'DH_PASS')]) {
                    sh 'echo "$DH_PASS" | docker login -u "$DH_USER" --password-stdin'
                    sh "docker push ${DOCKER_USER}/${TARGET}:latest"
                }
            }
        }

        stage('Deploy') {
            steps {
                sh "./deploy.sh ${TARGET}"
            }
        }
    }

    post {
        always {
            sh 'docker logout || true'
        }
    }
}