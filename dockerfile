# First stage: Maven build with JDK 13
FROM maven:3.6.3-jdk-11 as build
WORKDIR /app
COPY myapp /app
RUN mvn package

# Second stage: Setup the runtime environment with JDK 13
FROM openjdk:11-jdk-alpine
WORKDIR /app
COPY --from=build /app/target/myapp-1.0-SNAPSHOT.jar /app/myapp.jar
CMD ["java", "-jar", "myapp.jar"]
