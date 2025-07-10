# Utilise une image Java officielle
FROM openjdk:17-jdk-alpine

# Copie le jar compilé dans l'image
COPY target/*.jar app.jar

# Expose le port 8080
EXPOSE 8080

# Commande pour démarrer l'application
ENTRYPOINT ["java", "-jar", "/app.jar"]
