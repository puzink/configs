FROM openjdk:17-alpine
WORKDIR /app
COPY /target/Configurator.jar /app
EXPOSE 8080

CMD ["java", "-jar", "Configurator.jar"]
