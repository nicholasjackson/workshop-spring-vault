FROM openjdk:21

COPY build/libs/spring-vault-0.0.1-SNAPSHOT.jar /spring-vault-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java", "-Dspring.config.location=/config/application.yml", "-jar",  "/spring-vault-0.0.1-SNAPSHOT.jar"]