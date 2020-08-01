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

      }
    }

    stage('build image') {
      steps {
        sh '''hostname

docker container ls'''
        sh 'docker build -t 374191519168.dkr.ecr.us-east-2.amazonaws.com/smallcase-app:develop'
      }
    }

  }
}