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
                //sh 'docker build -t devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT .'
                //sh 'docker push devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'
                //sh 'docker rmi devops2022.azurecr.io/pierre_nginx:$GIT_COMMIT'
                sh 'docker build -t devops2022.azurecr.io/pierre/test:$BUILD_NUMBER .'
            }
        }

        stage('Image Pushing'){
            steps{
                sh 'docker push devops2022.azurecr.io/pierre/test:$BUILD_NUMBER'
            }
        }

        stage('Clone ManifestRepo'){
            steps {
                sh 'git clone https://github.com/Brights-DevOps-2022-Script/argocd.git K8s_pierre'
            }
        }

        stage('Update Deployment') {
            steps {
                sh 'cd K8s_pierre'
                sh 'sed -i "s/image: .*/image: pierre/test:$BUILD_NUMBER/" nginx.yml'
            }
        }

        stage('Commit Changes') {
            steps {
                sh 'git config --global user.email "pierfrancesco.elia89@gmail.com"'
                sh 'git config --global user.name "Pierre890"'
                sh 'git add nginx.yml'
                sh 'git commit -m "Update deployment with new image"'
                sh 'git push origin HEAD:master'
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