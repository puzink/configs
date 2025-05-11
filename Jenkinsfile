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
            steps {
                echo 'Start building image..'
                script {
                    def output = sh(script: "echo \$(whoami)", returnStdout: true)
                    echo "Output: ${output}"
                }
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
        stage('deploy on VM') {
            agent any
            environment {
                SERVER_IP = credentials('server-ip')
                USER_NAME = credentials('vm-username')
                DOCKER_REGISTRY_ID = credentials('yandex-docker-registry')
                PATH_TO_PRIVATE_KEY = credentials('path-to-private-key')
            }
            steps {
                echo 'Start deploying...'
                script {
                    def output = sh(script: "echo \$(whoami)", returnStdout: true)
                    echo "Output: ${output}"
                }
                sh "ssh -vvv -tt -o StrictHostKeyChecking=no -l $USER_NAME -i $PATH_TO_PRIVATE_KEY $SERVER_IP"
                echo 'These commands will be run on: $( uname -a )'
                sh '''
                    curl --header Metadata-Flavor:Google 169.254.169.254/computeMetadata/v1/instance/service-accounts/default/token | \
                    cut -f1 -d\',\' | \
                    cut -f2 -d\':\' | \
                    tr -d \'"\' | \
                    docker login --username iam --password-stdin cr.yandex
                '''
                sh "docker pull cr.yandex/${DOCKER_REGISTRY_ID}/configurator:${env.BUILD_ID}"
                echo 'Deploying has not been realized yet'    
            }
        }
    }
}
