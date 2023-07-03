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
                    sh 'mvn clean verify sonar:sonar \
  -Dsonar.projectKey=maven-project \
  -Dsonar.projectName='maven-project' \
  -Dsonar.host.url=http://43.207.136.9:9000 \
  -Dsonar.token=sqp_398c647ec4d640cc6b50da3f1e4510829bb1d7b3'
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
                    sh 'mvn sonar:sonar'
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
