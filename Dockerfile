# Stage 1: Build
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copia archivos de Maven y dependencias
COPY agenta/.mvn/ .mvn
COPY agenta/mvnw agenta/pom.xml ./
RUN ./mvnw dependency:go-offline

# Copia código fuente y compila
COPY agenta/src ./src
RUN ./mvnw clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copiar el jar generado
COPY --from=build /app/target/*.jar ./app.jar

# Render define el puerto en la variable $PORT
ENV PORT=10000

# Arrancar la aplicación
ENTRYPOINT ["java","-jar","app.jar"]
