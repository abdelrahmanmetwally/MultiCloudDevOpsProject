pipeline {
    agent any
    environment {
        
        DOCKER_REGISTRY = 'docker.io/abdo23'
        DOCKER_IMAGE = 'new-app-project'
        OPENSHIFT_TOKEN =  'https://api.ocpuat.devopsconsulting.org:6443'
        SERVER_NAME = 'sha256~2WTzYAScmhdm7sYQtPRuHx-4ZsuliaN2FGr4FDaNxq0 '
        OPENSHIFT_PROJECT = 'abdelrahman'
        SONARQUBE_TOKEN= '11986ba88cfe1b603256e331f33d03679486adc0'

        
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
                                    sh ' docker build -t abdo23/new-app-project:v${BUILD_NUMBER} . '
                                    sh ' docker push abdo23/new-app-project:v${BUILD_NUMBER} '
                                }
                    
                }
            }
        } 
        
        stage('sonar-qube') {
            steps {
                 
                 sh "./gradlew sonarqube -Dsonar.projectKey=ivolve-project -Dsonar.host.url=http://localhost:9000 -Dsonar.login=11986ba88cfe1b603256e331f33d03679486adc0"
               }   
        }

        stage('deploy') {
            steps {
                echo 'deploy'
                script {
                    sh ' echo hello'
                         
                                // withCredentials([file(credentialsId: 'openshift-credentials', variable: 'KUBECONFIG')]) {
                                //     sh '''
                                //         oc login --token=${SERVER_NAME} --server=https://api.ocpuat.devopsconsulting.org:6443  --insecure-skip-tls-verify
                                //         oc project abdelrahman
                                //         oc apply -f DeployRoute.yml --kubeconfig ${KUBECONFIG} -n abdelrahman
    
                                //     '''
                                // }
                         
                    }
                }
          }
    }
}
