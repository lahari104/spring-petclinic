pipeline{
    agent{
        label 'puppy' 
    }
    triggers{
        pollSCM('* * * * *')
    }
    parameters { choice(name: 'branch_trigger', choices: ['new', 'main'], description: 'selecting branch name') }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/lahari104/spring-petclinic.git',
                    branch: "${params.branch_trigger}"
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