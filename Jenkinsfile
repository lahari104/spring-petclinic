pipeline{
    agent{
        label 'self'
    }
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('clone and ansible'){
            steps{
                sh """
                    cd ansible/
                    ansible-playbook -i hosts ansible-jenkins.yaml
                """
            }
        }
    }
}