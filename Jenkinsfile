pipeline{
    agent{
        label 'ansible'
    }
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('clone and ansible'){
            steps{
                sh """
                    ansible -m ping -i hosts ansible-jenkins.yaml
                    ansible-playbook -i hosts ansible-jenkins.yaml
                """
            }
        }
    }
}