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
       stage('Remove image') {
             steps{
               sh "docker rmi $registry:$BUILD_NUMBER"
             }
           }
  }
}
node {
    stage('Execute Image'){
        def customImage = docker.build("ganeshviji1019/bsafe-application:${env.BUILD_NUMBER}")
        customImage.inside {
            RUN java -Dserver.port=8888 -jar target/com.simplilearn.bsafe-${BUILDNUMBER}.jar
        }
    }
}
