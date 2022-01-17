pipeline {
    environment {
    registry = "ganeshviji1019/bsafe-application"
    registryCredential = 'Docker'
  }
  triggers {
         pollSCM('* * * * *')
  }
  agent any
  stages{
        stage('Initialize') {
            steps {
                //define scm connection for polling
                git branch: 'main', credentialsId: 'jenkins1', url: 'https://github.com/ganesh1019/bsafe.git'
            }
        }
        stage('Build Application and Run Tests') {
                        steps{
                            script {
                                sh 'mvn clean install'
                            }
                         }
        }

        stage('Building Docker image') {
        steps{
            script {
            dockerImage = docker.build registry + ":latest"
            }
         }
        }

        stage('Deploy Image') {
        steps{
            script {
            docker.withRegistry( '', 'Docker' ) {
                dockerImage.push()
             }
            }
        }
       }
  }
}
node {
    stage('Execute Image'){
        def customImage = docker.build("ganeshviji1019/bsafe-application:latest")
        customImage.inside {
            sh 'Code inside Container'
        }
    }
}
node{
   stage('Remove image') {
             steps{
               sh "docker rmi $registry:latest"
             }
    }
}
