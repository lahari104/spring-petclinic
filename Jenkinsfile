pipeline{
    agent{
        label 'puppy' 
    }
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/lahari104/spring-petclinic.git',
                    branch: 'new'
            }
        }
        stage('build'){
            steps{
                sh """
                    docker build -t spc:1.0 .
                    docker run -d -P --name lahari spc:1.0
                    docker ps -a
                """
            }
        }
    }
}