pipeline{
    agent any
    triggers{
        pollSCM('* * * * *')
    }
    environment{
        AWS_CREDENTIALS = 'java_project'
    }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/lahari104/spring-petclinic.git',
                    branch: 'java-dockerfile'
            }
        }
        stage('build and push'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'java_project'  // Use Jenkins credentials ID
                ]]) {
                sh """
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 232589951422.dkr.ecr.us-east-1.amazonaws.com
                    docker image build -t 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID} .
                    docker image ls -a
                    docker push 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID}
                    docker run -d -P --name spc-${env.BUILD_ID} 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID}
                """
                }    
            }
        }
        stage('deploy'){
            steps{
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'java_project'  // Use Jenkins credentials ID
                ]]){
                sh """
                    aws eks update-kubeconfig --name eks-cluster --region us-east-1
                    cd Kubernetes/
                    kubectl apply -f .
                    kubectl get nodes
                    kubectl get pods
                """
                }
            }
        }
    }
}
