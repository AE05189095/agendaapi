# Stage 1: Build
FROM eclipse-temurin:17-jdk-jammy AS build
WORKDIR /app

# Copia archivos de Maven y dependencias
COPY agenda/.mvn/ .mvn
COPY agenda/mvnw agenda/pom.xml ./
RUN ./mvnw dependency:go-offline

# Copia código fuente y compila
COPY agenda/src ./src
RUN ./mvnw clean package -DskipTests

# Stage 2: Runtime
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copiar el jar generado desde la etapa de build
COPY --from=build /app/target/*.jar ./app.jar

# Render define el puerto en la variable $PORT
ENV PORT=10000

# Arrancar la aplicación
ENTRYPOINT ["java","-jar","app.jar"]

