pipeline {
    agent any
    environment{
        ACR_CRED = credentials('acr_creds')
        KUB_CONF = credentials('k8s_config')
    }
    stages {
        stage('build') {
            steps {
                sh 'az login --service-principal -u $ACR_CRED_CLIENT_ID -p $KUB_CONF_SECRET'
                sh 'apply -f deployment.yml -f service.yml -f load-balancer.yml -n pierre-space'
            }    
        }
    }
}