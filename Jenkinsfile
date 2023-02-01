pipeline {
    agent any 
    environment{
        ACR_CRED = credentials('acr_creds')
        KUB_CONF = credentials('k8s_config')
    }
    stages {
        stage('ACR Login') {
            agent any
            steps{
                sh 'docker login devops2022.azurecr.io -u $ACR_CRED_USR -p $ACR_CRED_PSW'
            }
        }
        stage('deploy') {
            agent {
                docker {
                    image 'gcr.io/cloud-builders/kubectl'
                    arg '-e KUB_CONF'
                }
            }
            steps{
                //sh 'kubectl --kubeconfig=$KUB_CONF delete namespace pierre-space-second'
                //sh 'kubectl --kubeconfig=$KUB_CONF create namespace pierre-space-second'
                sh 'kubectl apply -f nginx-deployment.yml -n pierre-space-second'
                sh 'kubectl get namespaces'
            }    
        }
    }   
}
