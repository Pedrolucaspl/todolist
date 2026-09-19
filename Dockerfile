# --- Estágio 1: Compilação (Build) ---
FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y \
    openjdk-21-jdk \
    maven

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# --- Estágio 2: Execução (Runtime) ---
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openjdk-21-jre

EXPOSE 8080

# Copia o jar compilado do estágio anterior
COPY --from=build /app/target/todolist-0.0.1-SNAPSHOT.jar /app/app.jar

WORKDIR /app
ENTRYPOINT ["java", "-jar", "app.jar"]