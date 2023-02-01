pipeline {
    agent any 
    environment{
        ACR_CRED = credentials('acr_creds')
        KUB_CONF = credentials('k8s_config')
    }
    stages {
        stage('ACR Login') {
            steps{
                sh 'docker login devops2022.azurecr.io -u $ACR_CRED_USR -p $ACR_CRED_PSW'
            }
        }
        stage('deploy') {
            agent {
                docker {
                    image 'alpine/k8s:1.23.16'
                }
            }
            steps{
                //sh 'kubectl --kubeconfig=$KUB_CONF delete namespace pierre-space-second'
                //sh 'kubectl --kubeconfig=$KUB_CONF create namespace pierre-space-second'
                withEnv(["VAR_NAME=KUB_CONF"]) {
                sh 'echo $KUB_CONF'
                sh 'kubectl --kubeconfig=$VAR_NAME apply -f nginx-deployment.yml -n pierre-space-second'
                sh 'kubectl --kubeconfig=$VAR_NAME get namespaces'
            }    
        }
    }   
}
