pipeline{
    agent any
        
    stages{
        stage("Code Checker"){
            steps{
                git branch: 'main', url: 'https://github.com/Nadav23AnT/docker-app-CI-CD'
            }
        }
        
        stage("Build image (docker)"){
            steps{
                sh 'docker image build -t nadav23chen/docker-app-ci-cd:v$BUILD_ID .'
                sh 'docker image tag nadav23chen/docker-app-ci-cd:v$BUILD_ID nadav23chen/docker-app-ci-cd:latest'
            }
        }
        
        stage("Push image"){
            steps{
                withCredentials([usernamePassword(credentialsId: '$YOUR_ID', passwordVariable: 'pass', usernameVariable: 'user')]) {
                    sh "docker login -u ${user} -p ${pass}"
                    sh 'docker push nadav23chen/docker-app-ci-cd:v$BUILD_ID'
                    sh 'docker push nadav23chen/docker-app-ci-cd:latest'
                    sh 'docker imgage rmi nadav23chen/docker-app-ci-cd:v$BUILD_ID nadav23chen/docker-app-ci-cd:latest'
                }
            }
        }
        
        stage("container creating"){
            steps{
                sh 'docker run -itd --name docker-app-ci-cd -p 3000:3000 nadav23chen/docker-app-ci-cd:latest'
            }
        }
    }
}