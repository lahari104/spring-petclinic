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
                      docker image build -t lahari23/insignia:${env.BUILD_ID} .
                      docker image ls
                      docker push lahari23/insignia:${env.BUILD_ID}
                      docker run -d -P --name spc-${env.BUILD_ID} lahari23/insignia:${env.BUILD_ID}
                    """
            }
        }
    }
}
