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
                sh """/opt/maven/bin/mvn clean package"""
            }
        }
        stage('archive artifacts'){
            steps{
                archiveArtifacts artifacts: '**/target/*.jar', followSymlinks: false
            }
        }
        stage('junit'){
            steps{
                junit '**/surefire-reports/*.xml'
            }
        }
    }
}