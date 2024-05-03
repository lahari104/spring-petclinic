pipeline{
    agent{
        label 'nexus'
    }
    triggers{
        pollSCM('* * * * *')
    }
    stages{
        stage('clone'){
            steps{
                git url: 'https://github.com/lahari104/spring-petclinic.git',
                    branch: 'nexus'
            }
        }
        stage('build'){
            steps{
                sh "./mvnw clean package"
            }
        }
        stage('nexus'){
            steps{
                script {
                    pom = readMavenPom file: "pom.xml";
                    filesByGlob = findFiles(glob: "target/*.jar");
                    echo "${filesByGlob[0].name} ${filesByGlob[0].path} ${filesByGlob[0].directory} ${filesByGlob[0].length} ${filesByGlob[0].lastModified}"
                    artifactPath = filesByGlob[0].path;
                    artifactExists = fileExists artifactPath;
                    if(artifactExists) {
                        echo "*** File: ${artifactPath}, group: ${pom.groupId}, packaging: ${pom.packaging}, version ${pom.version}";
                        nexusArtifactUploader(
                            nexusVersion: 'nexus3',
                            protocol: 'http',
                            nexusUrl: '100.25.131.22:8081',
                            groupId: 'pom.org.springframework.boot',
                            version: 'pom.3.0.1',
                            repository: 'maven-nexus',
                            credentialsId: 'ac09c93b-8645-4f88-90f3-077b7101bdcc',
                            artifacts: [
                                [artifactId: 'pom.spring-boot-starter-parent',
                                classifier: '',
                                file: "target/spring-petclinic-3.0.0-SNAPSHOT.jar",
                                type: "jar"],
                                [artifactId: 'pom.spring-boot-starter-parent',
                                classifier: '',
                                file: "pom.xml",
                                type: "pom"]
                            ]
                        );
                    } else {
                        error "*** File: ${artifactPath}, could not be found";
                    }
                }
            }
        }
    }
}