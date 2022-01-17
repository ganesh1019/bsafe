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
        stage('Build the Application') {
                        steps{
                            script {
                                sh 'mvn clean install'
                            }
                         }
        }
         stage('Build the Application') {
                                steps{
                                    script {
                                        sh 'mvn clean test'
                                    }
                                 }
                }
        stage('Building Docker image') {
        steps{
            script {
            dockerImage = docker.build registry + ":$BUILD_NUMBER"
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
        def customImage = docker.build("ganeshviji1019/bsafe-application:${env.BUILD_NUMBER}")
        customImage.inside {
            sh 'echo This is the code executing inside the container.'
        }
    }
}
