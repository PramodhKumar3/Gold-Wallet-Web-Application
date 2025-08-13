# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the jar file into the container
COPY target/SampleApp.jar SampleApp.jar

# Expose the port your Spring Boot app runs on
EXPOSE 8087

# Run the jar file
ENTRYPOINT ["java", "-jar", "SampleApp.jar"]