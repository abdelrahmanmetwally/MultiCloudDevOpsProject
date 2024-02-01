pipeline {
    agent any
    environment {
        
        DOCKER_REGISTRY = 'docker.io/abdo23'
        DOCKER_IMAGE = 'new-app-project'  
        SERVER_NAME =  'https://api.ocpuat.devopsconsulting.org:6443'
        OPENSHIFT_TOKEN = 'sha256~2WTzYAScmhdm7sYQtPRuHx-4ZsuliaN2FGr4FDaNxq0 '
        OPENSHIFT_PROJECT = 'abdelrahman'
        SONARQUBE_TOKEN= '11986ba88cfe1b603256e331f33d03679486adc0'
        SONARQUBE_PROJECTKEY= 'ivlove-project'

        
    }
   

   
    stages {
        stage('Checkout Repository') {
            steps {
                // Checkout the repository, specifying the branch
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

        stage('build') {
            steps {
                echo 'build'
                script{
                        
                                withCredentials([usernamePassword(credentialsId: 'dockerhub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                                    sh ' echo hello'
                                    sh ' docker login -u ${USERNAME} -p ${PASSWORD} '
                                    sh ' docker build -t ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:v${BUILD_NUMBER} . '
                                    sh ' docker push ${DOCKER_REGISTRY}/${DOCKER_IMAGE}:v${BUILD_NUMBER} '
                                }
                    
                }
            }
        } 
        
        stage('sonar-qube') {
            steps {
                 
                 sh "./gradlew sonarqube -Dsonar.projectKey=${SONARQUBE_PROJECTKEY} -Dsonar.host.url=http://localhost:9000 -Dsonar.login=${SONARQUBE_TOKEN}"
               }   
        }

        stage('deploy') {
            steps {
                echo 'deploy'
                script {
                    sh ' echo hello'
                         
                                withCredentials([file(credentialsId: 'openshift-credentials', variable: 'KUBECONFIG')]) {
                                    sh '''
                                        oc login --token=${OPENSHIFT_TOKEN} --server=${SERVER_NAME} --insecure-skip-tls-verify
                                        oc project ${OPENSHIFT_PROJECT}
                                        oc apply -f DeployRoute.yml --kubeconfig ${KUBECONFIG} -n ${OPENSHIFT_PROJECT}
    
                                    '''
                                }
                         
                    }
                }
          }
    }
}
