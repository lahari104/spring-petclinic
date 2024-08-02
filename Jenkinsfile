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
                    ansible -m ping -i hosts node
                    ansible-playbook -i hosts ansible-jenkins.yaml
                """
            }
        }
    }
}