pipeline {
    agent any
    
    stages {
        stage('Build') {
            steps {
                // Checkout source code from your version control system
                checkout scm
                
                // Set up Maven
                withMaven(maven: 'Maven 3') {
                    // Build the Maven project
                    sh 'mvn clean install'
                }
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
