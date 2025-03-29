pipeline {
    agent any
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
