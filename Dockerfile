FROM ubuntu:22.04
RUN apt update && \
    apt install openjdk-17-jdk -y && \
    apt install git -y && \
    git clone https://github.com/lahari104/spring-petclinic.git && \
    cd spring-petclinic && \
    ./mvnw package
EXPOSE 8080
CMD [ "java", "-jar", "*.jar" ]    
    
