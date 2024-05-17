pipeline {
agent any

tools {
  maven 'M2_HOME'
      }

stages {
   stage('Checkout') {
    steps {
      echo 'Checkout the source code from Github'
        git 'https://github.com/prajwaldevraj/banking-17may.git'
          }
    }
stage('Package') {
   steps {
     echo'Create a Package'
       sh 'mvn clean package'
         }
    }
stage('Publish Test Report') {
   steps {
     publishHTML([allowMissing: false, alwaysLinkToLastBuild: false, keepAll: false, reportDir: '/var/lib/jenkins/workspace/Prajwal-Banking-Project/target/surefire-reports', reportFiles: 'index.html', reportName: 'HTML Report', reportTitles: '', useWrapperFileDirectly: true])
         } 
    }

stage('Create Image using the package') {
   steps {
echo 'Creating a docker image from the package'
     sh 'docker build -t prajwal1602/banking:1.0 .'
         }
     }
stage('Docker Login') {
  steps {
    echo 'Login to Docker hub to pushthe images'
      withCredentials([usernamePassword(credentialsId: 'Dockerlogin-user', passwordVariable: 'dockerhubpass', usernameVariable: 'dockerhublogin')]) {
      sh 'docker login -u ${dockerhublogin} -p ${dockerhubpass}'
                       }
            }
      }
stage('Push the Image') {
   steps {
      sh 'docker push prajwal1602/banking:1.0'
                        }
         }
  stage('Create Infrastructure using terraform') {
    steps {
      dir('scripts') {
        sh 'sudo chmod 600 insurnace-14may.pem'
        sh 'terraform init'
        sh 'terraform validate'
        sh 'terraform apply --auto-approve'
                     }
           }
      }
   }
}
