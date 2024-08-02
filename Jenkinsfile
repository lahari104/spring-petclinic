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
                    ansible -m ping -i hosts all
                    ansible-playbook -i hosts ansible-jenkins.yaml
                """
            }
        }
    }
}