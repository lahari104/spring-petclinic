FROM ubuntu:22.04
RUN apt update && apt install openjdk-17-jdk -y 
RUN apt install git -y
RUN git clone https://github.com/lahari104/spring-petclinic.git && \
    cd spring-petclinic && \
    ./mvnw package 
EXPOSE 8080
CMD [ "java", "-jar", "/spring-petclinic/target/spring-petclinic-3.0.0-SNAPSHOT.jar" ]