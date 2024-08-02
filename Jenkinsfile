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
                    ansible all -i hosts -m ping -vvv
                    ansible-playbook -i hosts ansible-jenkins.yaml
                """
            }
        }
    }
}