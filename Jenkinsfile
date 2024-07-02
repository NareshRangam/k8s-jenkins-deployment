pipeline{

    agent any
    tools{
        maven "maven"
    }
    environment {     
        APP_NAME = "kubernetes-simple-app"
        RELEASE_NO = "1.0.0"
        DOCKER_USER = "rangamnaresh"
        IMAGE_NAME = "${DOCKER_USER}/${APP_NAME}"
        IMAGE_TAG = "${RELEASE_NO}-${BUILD_NUMBER}"    
  }
    stages{

        stage("SCM checkout"){
            steps{
                checkout scmGit(branches: [[name: '*/main']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/NareshRangam/k8s-jenkins-deployment.git']])
            }
        }

        stage("Build Process"){
            steps{
                script{
                    bat 'mvn clean install'
                }
            }
        }
        
        stage("build Image")
        {
            steps{
                script{
                    bat 'docker build -t %IMAGE_NAME%:%BUILD_NUMBER% .'
                }
            }
        }
        
       stage("Push Image to Docker Hub"){
            steps{
                withCredentials([string(credentialsId: 'credentials-dockerhub', variable: 'docker-variable')]) {
                    bat 'docker login -u rangamnaresh -p %docker-variable%'
                    bat 'docker push %IMAGE_NAME%:%BUILD_NUMBER%'
                }
            }

        }
        stage("Deploy to K8S")
        {
            steps{
                script{
                    kubeconfig(credentialsId: 'kubeconfig-pwd', serverUrl: '') {
                bat """powershell -Command "(Get-Content k8s-deployment.yml) -replace 'image: .*', 'image: %IMAGE_NAME%:%BUILD_NUMBER%' | Set-Content k8s-deployment.yml" """
                    bat 'kubectl apply -f k8s-namespace.yml'
                     bat 'kubectl apply -f k8s-deployment.yml'
                      bat 'kubectl apply -f k8s-service.yml'
    
            }
                }
              
                   
            }
        }
        
        stage("verify pods")
        {
           steps{
                script{
                    kubeconfig(credentialsId: 'kubeconfig-pwd', serverUrl: '') {
                    bat 'kubectl get pods -n rangam-namespace'
                }
                }
        }
        
}
}
    
}

