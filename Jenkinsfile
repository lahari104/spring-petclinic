pipeline{
    agent {
        label 'sonar-spc'
    }
    triggers {
        pollSCM('* * * * *')
    }
    stages {
        stage('clone'){
            steps{
                git url: 'https://github.com/lahari104/spring-petclinic.git',
                    branch: 'sonarqube'
            }
        }
        stage('build'){
            "sh ./mvnw package"
        }
    }
}