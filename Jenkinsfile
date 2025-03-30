pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.9.9-eclipse-temurin-17'
                    args '-v $HOME/.m2:/root/.m2'

                }
            }
            steps {
                echo 'Start building..' 
                sh 'mvn -B -DskipTests clean package'
                echo 'Building has been finished!'
            }
        }
        stage('Build image') {
            agent {
                docker {
                    image 'docker:28.0.4'
                    args '-v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            environment {
                HOME = "${env.WORKSPACE}"
            }
            steps {
                echo 'Start building image..'
                sh 'compgen -u'
                sh 'ls -l /var/run/docker.sock'
                sh "docker build -t Configurator:${env.BUILD_ID} ."
                echo 'Finished image building!'    
            }
        }
    
        stage('delivery to docker registry') {
            steps {
                echo 'Start delivering..' 
                echo 'Delivery has not been realized yet'    
            }
        }
        stage('deploy') {
            steps {
                echo 'Start deploying...'
                echo 'Deploying has not been realized yet'    
            }
        }
    }
}
