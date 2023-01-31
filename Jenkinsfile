pipeline {
    agent any
    environment{
        ACR_CRED = credentials('acr_creds')
    }
    stages {
        stage('build') {
            steps {
                sh 'az login --service-principal -u $ACR_CRED_CLIENT_ID -p $ACR_CRED_CLIENT_SECRET -t $ACR_CRED_TENANT_ID'
                sh 'apply -f deployment.yml -f service.yml -f load-balancer.yml -n pierre-space'
            }    
        }
    }
}