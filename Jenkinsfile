pipeline {
    agent { 
        kubernetes { 
            label 'app' 
        } 
    }
}   environment{
        ACR_CREDENTIAL = credentials('acr_creds')

    }
    stages {
        stage('build') {
            steps {
                sh 'az login --service-principal -u $ACR_CREDENTIAL_USR -p $ACR_CREDENTIAL_PSW'
                sh 'apply -f deployment.yml -f service.yml -f load-balancer.yml -n pierre-space'
            }    
        }
    }