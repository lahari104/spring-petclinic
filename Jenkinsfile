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
                    git clone "https://github.com/lahari104/spring-petclinic.git"
                    cd spring-petclinic
                    ansible -m ping -i hosts ansible-jenkins.yaml
                    ansible-playbook -i hosts ansible-jenkins.yaml
                """
            }
        }
    }
}