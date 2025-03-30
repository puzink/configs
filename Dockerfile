FROM openjdk:17-alpine
RUN apk update && apk add bash
WORKDIR /app
COPY /target/Configurator.jar /app
EXPOSE 8080

CMD ["java", "-jar", "Configurator.jar"]
