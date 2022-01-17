pipeline {
   environment {
      registry = "ganeshviji1019/bsafe-application"
      registryCredential = 'Docker'
   }
   triggers {
      pollSCM('* * * * *')
   }
   agent any
   stages {
      stage('Initialize') {
         steps {
            //define scm connection for polling
            git branch: 'main', credentialsId: 'jenkins1', url: 'https://github.com/ganesh1019/bsafe.git'
         }
      }
      stage('Build Application and Run Tests') {
         steps {
            script {
               sh 'mvn clean install'
            }
         }
      }

      stage('Building Docker image') {
         steps {
            script {
               dockerImage = docker.build registry + ":latest"
            }
         }
      }

      stage('Deploy Image') {
         steps {
            script {
               docker.withRegistry('', 'Docker') {
                  dockerImage.push()
               }
            }
         }
      }

      stage('Execute Image') {
         steps {
            script {
               sh 'docker images'
               sh 'docker run $registry:latest'
            }
         }
      }

    stage('Stop and Remove All containers') {
          steps {
                sh 'docker stop $(docker ps -a -q)'
                sh 'docker rm $(docker ps -a -q)'
          }
       }
   }
}


