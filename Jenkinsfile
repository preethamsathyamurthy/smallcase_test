pipeline {
  agent any
  stages {
    stage('check python version') {
      parallel {
        stage('check python version') {
          steps {
            sh 'python --version'
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