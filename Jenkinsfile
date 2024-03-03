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
        DOCKER_HUB_REG_NAME = "lahari23/spclinic"
        ECR_REG_NAME = "232589951422.dkr.ecr.us-east-1.amazonaws.com/spc"
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
                    docker tag $env.image_name:v${BUILD_NUMBER} ${DOCKER_HUB_REG_NAME}:spc-v${BUILD_NUMBER}
                    docker push ${DOCKER_HUB_REG_NAME}:spc-v${BUILD_NUMBER}
                    docker image ls
                    docker ps -a
                """
            }
        }
    }
    post{
        always{
            echo "The pipeline is started! for $JOB_NAME"
            mail to: "laharigoruputi2001@gmail.com"
                 body: """
                    Build is started for $BUILD_URL
                 """
                 subject: "Pipeline Status"
        }
        failure{
            echo "The pipeline is failed! for $JOB_NAME"
            mail to: "laharigoruputi2001@gmail.com"
                 body: """
                    Build is failed for $BUILD_URL
                 """
                 subject: "Pipeline Status"
        }
        aborted{
            echo "The pipeline is aborted! for $JOB_NAME"
            mail to: "laharigoruputi2001@gmail.com"
                 body: """
                    Build is aborted for $BUILD_URL
                 """
                 subject: "Pipeline Status"
        }
        success{
            echo "The pipeline is success! for $JOB_NAME"
            mail to: "laharigoruputi2001@gmail.com"
                 body: """
                    Build is successful for $BUILD_URL
                 """
                 subject: "Pipeline Status"
        }
    }
} 