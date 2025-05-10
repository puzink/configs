pipeline {
    agent none
    stages {
        stage('Build') {
            agent {
                docker {
                    image 'maven:3.9.9-eclipse-temurin-17'
                    args '-v $HOME/.m2:/root/.m2 -v /var/run/docker.sock:/var/run/docker.sock'
                }
            }
            steps {
                echo 'Start building..' 
                sh 'mvn -B -DskipTests clean package'
                echo 'Building has been finished!'
            }
        }
        stage('Build image') {
            agent any
            environment {
                HOME = "${env.WORKSPACE}"
            }
            steps {
                echo 'Start building image..'
                sh "docker build -t configurator:${env.BUILD_ID} ."
                echo 'Finished image building!'    
            }
        }
    
        stage('delivery to docker registry') {
            agent any
            environment {
                DOCKER_REGISTRY_ID = credentials('yandex-docker-registry')
                OATH_TOKEN = credentials('oath-yandex-console')
            }
            steps {
                echo 'Start delivering..'
                sh "docker login --username oauth --password ${OATH_TOKEN} cr.yandex"
                sh "docker tag configurator:${env.BUILD_ID} cr.yandex/${DOCKER_REGISTRY_ID}/configurator"
                sh "docker push cr.yandex/${DOCKER_REGISTRY_ID}/configurator"
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
