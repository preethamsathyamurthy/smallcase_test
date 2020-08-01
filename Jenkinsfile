pipeline {
  agent {
    docker {
      image 'python:3.8-alpine'
    }

  }
  stages {
    stage('check python version') {
      parallel {
        stage('check python version and pip3 version') {
          steps {
            sh '''python3 --version
pip3 --version'''
          }
        }

        stage('check current directory') {
          steps {
            sh 'pwd'
          }
        }

      }
    }

    stage('check directory contents') {
      steps {
        sh 'ls'
      }
    }

  }
}