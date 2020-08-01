pipeline {
  agent any
  stages {
    stage('check python version and pip3 version') {
      parallel {
        stage('check python version and pip3 version') {
          steps {
            sh '''python3 --version
pip3 --version'''
          }
        }

        stage('getting branch name') {
          steps {
            sh 'echo \'Pulling...\' + env.BRANCH_NAME'
          }
        }

        stage('get current directory and file contents') {
          steps {
            sh '''pwd
                  ls
                  branch=$( git branch | grep \'^*\' |awk \'{print $2}\')
                  echo $branch'''
          }
        }

      }
    }

    stage('build image for development') {
      when {
                branch 'develop' 
           }
      steps {
        sh 'docker build -t 374191519168.dkr.ecr.us-east-2.amazonaws.com/smallcase-app:develop .'
      }
    }
    stage('build image for staging') {
      when {
                branch 'staging' 
           }
      steps {
        sh 'docker build -t 374191519168.dkr.ecr.us-east-2.amazonaws.com/smallcase-app:green .'
      }
    }
    
    stage('Push image for development') {
        when {
                branch 'develop' 
           }
           steps {
               script {
                    docker.withRegistry('https://374191519168.dkr.ecr.us-east-2.amazonaws.com', 'ecr:us-east-2:awsContainerCredential') {
                        sh "docker push 374191519168.dkr.ecr.us-east-2.amazonaws.com/smallcase-app:develop"
                    }
               }
           }
    }
  }
}
