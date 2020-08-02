pipeline {
  agent any
  stages {
    stage('initial check') {
      parallel {
        stage('check python version and pip3 version') {
          steps {
            sh '''python3 --version
                  pip3 --version'''
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

    stage('Installing dependencies and building the app') {
        steps {
            sh '''
                    #!/bin/bash
                    pwd
                    #copy the build folders into a specific directory
                    mkdir build
                    cp -t ./build app.py templates requirements.txt uwsgi.ini -r
                    cd ./build
                    pwd
                    #install virutal env
                    python3 -m venv projectEnv
                    pwd
                    #login to virtualenv
                    source ./projectEnv/bin/activate
                    #to ensure that our packages will install even if they are missing wheel archives
                    pip install wheel
                    #installing dependencies
                    pip install -r requirements.txt
                    #moving out of virtual env
                    deactivate
                '''
        }
    }

    stage('perform unit tests if any') {
        steps {
            sh '''
                   pwd
                '''
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

    stage('build image for production') {
      when {
                branch 'master' 
           }
      steps {
        sh 'docker build -t 374191519168.dkr.ecr.us-east-2.amazonaws.com/smallcase-app:blue .'
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
    
    stage('Push image for staging/green deployment') {
        when {
                branch 'staging' 
        }
        steps {
            script {
                docker.withRegistry('https://374191519168.dkr.ecr.us-east-2.amazonaws.com', 'ecr:us-east-2:awsContainerCredential') {
                    sh "docker push 374191519168.dkr.ecr.us-east-2.amazonaws.com/smallcase-app:green"
                }
            }
        }
    }

    stage('Push image for staging/blue deployment') {
        when {
                branch 'master' 
        }
        steps {
            script {
                docker.withRegistry('https://374191519168.dkr.ecr.us-east-2.amazonaws.com', 'ecr:us-east-2:awsContainerCredential') {
                    sh "docker push 374191519168.dkr.ecr.us-east-2.amazonaws.com/smallcase-app:blue"
                }
            }
        }
    }

    stage('check kubectl') {
        steps {
        sh 'kubectl get nodes'
      }
    }

  }
}
