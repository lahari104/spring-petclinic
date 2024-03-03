pipeline{
    agent{
        label 'puppy' 
    }
    triggers{
        pollSCM('* * * * *')
    }
    parameters { choice(name: 'branch_trigger', choices: ['new', 'main'], description: 'selecting branch name') }
    environment{
        image_name = "spc"
        container_name = "spring-petclinic"
    }
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
                    docker build -t $env.image_name:v${BUILD_NUMBER} .
                    docker run -d -P --name $env.container_name-${BUILD_NUMBER} $env.image_name:v${BUILD_NUMBER}
                    docker image rm spc:1.0
                    docker rm -f lahari
                    docker image ls
                    docker ps -a
                """
            }
        }
    }
} 