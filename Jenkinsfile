pipeline {
    agent {
        docker {
            image 'maven:3.9.9-eclipse-temurin-17'
            args '-v $HOME/.m2:/root/.m2'
        }
    }
    stages {
        stage('Build') {
            steps {
                echo 'Start building..' 
                bat 'mvn -B -DskipTests clean package'
                archiveArtifacts artifacts: '**/target/Configurator.jar', fingerprint: true
                echo 'Building has been finished!'
            }
        }
        stage('delivery') {
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
