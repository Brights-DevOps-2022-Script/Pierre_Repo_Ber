pipeline {
    agent any 
    environment{
        ACR_CRED = credentials('acr_creds')
    }
    stages {
        stage('ACR Login') {
            steps{
                sh 'docker login devops2022.azurecr.io -u $ACR_CRED_USR -p $ACR_CRED_PSW'
            }
        }
        stage('Image Building') {
            steps {
                sh 'docker build -t devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT .'
                sh 'docker push devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'
                sh 'docker rmi devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'
            }
        }
        stage('Deploy') {
            agent {
                docker {
                    image 'alpine/k8s:1.23.16'
                    args '-u root'
                }
            }
            environment{
                 KUB_CONF = credentials('k8s_config')
            }
            steps{
                //sh 'kubectl --kubeconfig=$KUB_CONF delete namespace pierre-space-second'
                //sh 'kubectl --kubeconfig=$KUB_CONF create namespace pierre-space-second'
                // SED ..................
                sh 'kubectl --kubeconfig=$KUB_CONF apply -f nginx.yml'
                sh 'kubectl --kubeconfig=$KUB_CONF get namespaces'   
                sh 'kubectl --kubeconfig=$KUB_CONF set image -n pierre-space-second deployment/nginx-deployment-pierre nginx=devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'             
                sh 'kubectl --kubeconfig=$KUB_CONF get all -n pierre-space-second'
                sh 'kubectl --kubeconfig=$KUB_CONF get services -n pierre-space-second'
                sh 'apk update && apk add xdg-utils'
                sh 'LOAD_BALANCER_IP=$(kubectl --kubeconfig=$KUB_CONF get service load-balancer -n pierre-space-second -o jsonpath="{.status.loadBalancer.ingress[0].ip}")'
                sh 'echo "${LOAD_BALANCER_IP}"'
                sh 'open "http://${LOAD_BALANCER_IP}"'
                //sh 'kubectl --kubeconfig=$KUB_CONF expose deployment nginx-deployment-pierre -n pierre-space-second'
            }
        }
    }   
}