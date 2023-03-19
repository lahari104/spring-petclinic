pipeline{
    agent{
        label 'node-1'
    }
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/lahari104/spring-petclinic.git',
                    branch: 'lahari'
            }
        }
        stage('build'){
            steps{
                sh """mvn clean package"""
            }
        }
    }
}