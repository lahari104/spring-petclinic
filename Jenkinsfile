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
                            nexusUrl: '100.25.4.7:8081',
                            groupId: 'org.springframework.samples',
                            version: '3.0.0-SNAPSHOT',
                            repository: 'maven-nexus',
                            credentialsId: 'NexusID',
                            artifacts: [
                                [artifactId: 'spring-petclinic',
                                classifier: '',
                                file: "target/spring-petclinic-3.0.0-SNAPSHOT.jar",
                                type: "jar"]
                                
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