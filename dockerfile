FROM maven:3.6.3-jdk-11-slim AS build
WORKDIR /app
COPY myapp /app
RUN mvn package

FROM openjdk:11-jre-slim
WORKDIR /app
COPY --from=build /app/target/*.jar /app/myapp.jar
RUN groupadd -r terran && useradd -r -g terran terran
USER terran

CMD ["java", "-jar", "/app/myapp.jar"]
