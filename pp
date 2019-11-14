pipeline {
   agent any
   tools { maven 'MAVEN_HOME' }
   stages {
      stage('Github-Code Checkout') {
         steps {
            git url: 'https://github.com/prabhakar1990/game-of-life.git'
         }
      }
      stage ('Maven- Code Build') {
          steps {
             withSonarQubeEnv('Sonarqube') {
               sh 'mvn clean install sonar:sonar'
          }
          }
      }

      stage ('Sonarqube- Code Quality Analysis') {
          steps {
             withSonarQubeEnv('Sonarqube') {
               sh 'mvn clean install sonar:sonar'
          }
          }
      }
      stage ('Deploy to tomcat') {
         steps {
            sh 'chmod 755 deploy.sh'
            sh 'sh deploy.sh'
         }
      }   
    
   }  
   
}

