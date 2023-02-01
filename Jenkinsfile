pipeline {
    agent {
        docker {
            image 'docker:pierre'
        }
    }
    stages {
        stage("Build Docker Image") {
            steps {
                script {
                    def customImage = docker.build("myimage")
                }
            }
        }
    }
    environment{
        ACR_CRED = credentials('acr_creds')
        KUB_CONF = credentials('k8s_config')
    }
    stages {
        stage('ACR Login'){
            steps{
                sh 'docker login devops2022.azurecr.io -u $ACR_CRED_USR -p $ACR_CRED_PSW'
            }
        }
        stage('deploy') {
            steps {
                sh 'kubectl --kubeconfig=$KUB_CONF get nodes'
                //sh 'kubectl --kubeconfig=$KUB_CONF delete namespace pierre-space-second'
                //sh 'kubectl --kubeconfig=$KUB_CONF create namespace pierre-space-second'
                sh 'kubectl --kubeconfig=$KUB_CONF apply -f nginx-deployment.yml -n pierre-space-second'
                sh 'kubectl --kubeconfig=$KUB_CONF get namespaces'
            }    
        }
    }   
}
