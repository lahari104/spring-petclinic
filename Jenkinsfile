pipeline {
    agent any
    
    triggers {
        pollSCM('* * * * *')
    }
    
    environment {
        AWS_CREDENTIALS = 'java_project'
    }
    
    stages {
        stage('Clone SPC') {
            steps {
                git url: 'https://github.com/lahari104/spring-petclinic.git', branch: 'java-dockerfile'
            }
        }
        
        stage('Build and Push SPC') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'java_project' // Use Jenkins credentials ID
                ]]) {
                    sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 232589951422.dkr.ecr.us-east-1.amazonaws.com
                        docker image build -t 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID} .
                        docker image ls
                        docker push 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:${env.BUILD_ID}
                    """
                }
            }
        }
        
        stage('Deploy SPC to EKS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'java_project' // Use Jenkins credentials ID
                ]]) {
                    sh """
                        aws eks update-kubeconfig --name eks-cluster --region us-east-1
                        cd Kubernetes/
                        kubectl apply -f .
                        kubectl get nodes
                        kubectl get pods
                        kubectl get svc
                    """
                }
            }
        }
        
        stage('Clone Student Courses REST API') {
            steps {
                git url: 'https://github.com/lahari104/StudentCoursesRestAPI.git', branch: 'master'
            }
        }
        
        stage('Build and Push Student REST API') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'java_project' // Use Jenkins credentials ID
                ]]) {
                    sh """
                        aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 232589951422.dkr.ecr.us-east-1.amazonaws.com
                        docker image build -t 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:student-rest-api-${env.BUILD_ID} .
                        docker image ls
                        docker push 232589951422.dkr.ecr.us-east-1.amazonaws.com/insignia:student-rest-api-${env.BUILD_ID}
                    """
                }
            }
        }
        
        stage('Deploy Student REST API to EKS') {
            steps {
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'java_project' // Use Jenkins credentials ID
                ]]) {
                    sh """
                        aws eks update-kubeconfig --name eks-cluster --region us-east-1
                        cd kubernetes/
                        kubectl apply -f .
                        kubectl get nodes
                        kubectl get pods
                        kubectl get svc
                    """
                }
            }
        }
    }
}