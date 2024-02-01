@Library('my-jenkins-shared-library') _
// its link is : https://github.com/abdelrahmanmetwally/my-jenkins-shared-library.git

pipeline {
    agent any

    environment {
        USERNAME        = '$USERNAME'
        PASSWORD        = '$PASSWORD'
        DOCKER_REGISTRY = 'abdo23'
        DOCKER_IMAGE    = 'new-app-project'
        // BUILD_NUMBER    = '1'
        SERVER_NAME     = 'https://api.ocpuat.devopsconsulting.org:6443'
        OPENSHIFT_PROJECT = 'abdelrahman'
        SONARQUBE_PROJECTKEY = 'abdoMetwally' 
        SONARQUBE_TOKEN = 'SONARQUBE_TOKEN'
        SONARQUBE_HOST_URL = 'http://35.174.15.158:9000'
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
                 
                 sh "./gradlew sonarqube -Dsonar.projectKey=${SONARQUBE_PROJECTKEY} -Dsonar.host.url=${SONARQUBE_HOST_URL} -Dsonar.login=${SONARQUBE_TOKEN}"
               }   
        }        

        stage('deployToOpenShift') {
            steps {
                script {
                    deployToOpenShift(
                        SERVER_NAME: env.SERVER_NAME,
                        OPENSHIFT_PROJECT: env.OPENSHIFT_PROJECT,
                        KUBECONFIG: env.KUBECONFIG
                    )
                }
            }
        }
    }
}
