pipeline {
    agent any 
    environment{
        ACR_CRED = credentials('acr_creds')
        GIT_CRED = credentials('2eb747c4-f19f-4601-ab83-359462e62482')
    }
    stages {
        stage('ACR Login') {
            steps{
                sh 'docker login devops2022.azurecr.io -u $ACR_CRED_USR -p $ACR_CRED_PSW'
            }
        }

        stage('Image Building') {
            steps {
                //sh 'docker build -t devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT .'
                //sh 'docker push devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'
                //sh 'docker rmi devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'
                sh 'docker build -t devops2022.azurecr.io/team1/test:$BUILD_NUMBER .'
            }
        }

        stage('Image Pushing'){
            steps{
                sh 'docker push devops2022.azurecr.io/team1/test:$BUILD_NUMBER'
            }
        }

        stage('Update Deployment') {
            steps {
                sh 'sed -i "s|image: .*|image: pierre/test:$BUILD_NUMBER|" Kub_pierre/nginx.yaml'
                sh 'git add Kub_pierre/nginx.yaml'
                sh 'git commit -m "new deployment"'
                sh("git push https://$GIT_CRED_USR:$GIT_CRED_PSW@github.com/Brights-DevOps-2022-Script/argocd-team1.git HEAD:main")
            }
        }
        //stage('Deploy') {
          //  agent {
            //    docker {
              //      image 'alpine/k8s:1.23.16'
                //    args '-u root'
                //}
            //}
            //environment{
              //   KUB_CONF = credentials('k8s_config')
            //}
            //steps{
              //  withKubeConfig([credentialsId: 'k8s_config']){
                    //sh 'kubectl delete namespace pierre-space-second'
                    //sh 'kubectl create namespace pierre-space-second'
                    // SED ..................
                    //sh 'kubectl apply -f nginx.yml'
                    //sh 'kubectl get namespaces'   
                    //sh 'kubectl set image -n pierre-space-second deployment/nginx-deployment-pierre nginx=devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'             
                    //sh 'kubectl get all -n pierre-space-second'
                    //sh 'kubectl get services -n pierre-space-second'
                    //sh 'apk update && apk add xdg-utils'
                
                    //script{
                        //def output = sh(script: 'kubectl --kubeconfig=$KUB_CONF get service load-balancer -n pierre-space-second', returnStdout: true)
                        //LOAD_BALANCER_IP=output.split("\n")[1].split()[3].toString()
                        //echo "IP: http://${LOAD_BALANCER_IP}"
                    //}
                //}
            //}
       // }
    }   
}