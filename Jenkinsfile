@Library('your-shared-library') _

pipeline {
    agent any

    environment {
        USERNAME        = '$USERNAME'
        PASSWORD        = 'PASSWORD'
        DOCKER_REGISTRY = 'abdo23'
        DOCKER_IMAGE    = 'new-app-project'
        // BUILD_NUMBER    = '1'
        SERVER_NAME     = 'https://api.ocpuat.devopsconsulting.org:6443'
        OPENSHIFT_TOKEN = 'sha256~2WTzYAScmhdm7sYQtPRuHx-4ZsuliaN2FGr4FDaNxq0'
        OPENSHIFT_PROJECT = 'abdelrahman'
    }

    stages {
        stage('Checkout Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/abdelrahmanmetwally/MultiCloudDevOpsProject.git'
            }
        }

        stage('Run Tests') {
            steps {
                script {
                    sh './gradlew test'
                }
            }
        }

        stage('buildAndPush') {
            steps {
                script {
                    buildAndPush(
                        USERNAME: env.USERNAME,
                        PASSWORD: env.PASSWORD,
                        DOCKER_REGISTRY: env.DOCKER_REGISTRY,
                        DOCKER_IMAGE: env.DOCKER_IMAGE,
                        BUILD_NUMBER: env.BUILD_NUMBER
                    )
                }
            }
        }
        stage('sonar-qube') {
            steps {
                 
                 sh "./gradlew sonarqube -Dsonar.projectKey=${SONARQUBE_PROJECTKEY} -Dsonar.host.url=http://localhost:9000 -Dsonar.login=${SONARQUBE_TOKEN}"
               }   
        }        

        stage('deployToOpenShift') {
            steps {
                script {
                    deployToOpenShift(
                        OPENSHIFT_TOKEN: env.OPENSHIFT_TOKEN,
                        SERVER_NAME: env.SERVER_NAME,
                        OPENSHIFT_PROJECT: env.OPENSHIFT_PROJECT,
                        KUBECONFIG: env.KUBECONFIG
                    )
                }
            }
        }
    }
}
