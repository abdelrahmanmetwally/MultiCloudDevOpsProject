pipeline {
    agent any
    environment {
        login = 'sha256~J_11a-2Wq26kQ5V-gdq1Ck180gitT3ixC9Ob5byKkiA'

   }
    stages {
        stage('build') {
            steps {
                echo 'build'
                script{
                        
                                withCredentials([usernamePassword(credentialsId: 'docker-hub-credentials', usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD')]) {
                                    sh ' echo hello'
                                    sh ' docker login -u ${USERNAME} -p ${PASSWORD} '
                                    sh ' docker build -t abdo23/bakehouseiti:v${BUILD_NUMBER} . '
                                    sh ' docker push abdo23/bakehouseiti:v${BUILD_NUMBER} '
                                }
                    
                }
            }
        }
        stage('deploy') {
            steps {
                echo 'deploy'
                script {
                         
                                withCredentials([file(credentialsId: 'openshift-credentials', variable: 'KUBECONFIG')]) {
                                    sh '''
                                        oc login --token=${login} --server=https://api.ocpuat.devopsconsulting.org:6443  --insecure-skip-tls-verify
                                        oc project sample-app
                                        oc create deployment app --image=openshiftivolve --replicas=1 --kubeconfig ${KUBECONFIG} -n sample-app
    
                                    '''
                                }
                         
                    }
                }
          }
    }
}
