# --- Estágio 1: Compilação ---
FROM ubuntu:latest AS build

RUN apt-get update && apt-get install -y \
    openjdk-27-jdk \
    maven

WORKDIR /app
COPY . .

RUN mvn clean package -DskipTests

# --- Estágio 2: Execução ---
FROM ubuntu:latest

RUN apt-get update && apt-get install -y \
    openjdk-26-jre

EXPOSE 8080

COPY --from=build /app/target/todolist-0.0.1-SNAPSHOT.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]