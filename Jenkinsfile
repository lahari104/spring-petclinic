pipeline{
    agent any
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/lahari104/spring-petclinic.git',
                    branch: 'java-dockerfile'
            }
        }
        stage('build and deploy'){
            steps{
                sh """
                      docker image build -t 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID} .
                      docker image ls -a
                      docker push 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID}
                      docker run -d -P --name spc-${env.BUILD_ID} 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID}
                    """
            }
        }
    }
}
