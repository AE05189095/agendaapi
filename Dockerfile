# Stage 1: Build
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copiar archivos de Gradle
COPY gradlew .
COPY gradle gradle
COPY build.gradle settings.gradle ./
COPY src ./src

# Dar permisos de ejecución a gradlew
RUN chmod +x gradlew

# Build del proyecto
RUN ./gradlew build -x test

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copiar jar generado desde build
COPY --from=build /app/build/libs/*.jar ./app.jar

# Puerto
ENV PORT=10000

# Comando para correr la app
ENTRYPOINT ["java","-jar","app.jar"]

