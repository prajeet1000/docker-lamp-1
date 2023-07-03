pipeline {
    agent any

    stages {
        stage('SCM') {
            steps {
                checkout scm
            }
        }
        
        stage('SonarQube Analysis') {
            steps {
                // Configure SonarQube server
                script {
                    def scannerHome = tool 'SonarQubeScanner'
                    env.PATH = "${scannerHome}/bin:${env.PATH}"
                }
                
                // Run SonarQube analysis
                withSonarQubeEnv('SonarQube Server') {
                    sh 'mvn clean verify sonar:sonar -Dsonar.projectKey=maven-project -Dsonar.projectName="maven-project"'
                }
            }
        }
    }
    
    post {
        always {
            // Publish the generated reports
            script {
                // Set up SonarQube server credentials
                withSonarQubeEnv('SonarQube Server') {
                    // Publish Quality Gate results
                    // This will mark the build as failed if the quality gate criteria are not met
                    waitForQualityGate()
                }
            }
        }
    }
}
