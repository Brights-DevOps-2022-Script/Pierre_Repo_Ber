pipeline {
    agent any
    environment{
        ACR_CRED = credentials('acr_creds')
        KUB_CONF = credentials('k8s_config')
    }
    stages {
        stage('deploy') {
            steps {
                sh 'docker login -u $ACR_CRED_USR -p $ACR_CRED_PSW'
                sh 'kubectl --kubeconfig=$KUB_CONF get nodes'
                sh 'kubectl --kubeconfig=$KUB_CONF create namespace pierre-space'
                sh 'kubectl --kubeconfig=$KUB_CONF apply -f deployment.yml -f service.yml -f load-balancer.yml -n pierre-space'
            }    
        }
    }
}