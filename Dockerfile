# Stage 1: Compila la aplicación usando una imagen de Java Development Kit (JDK)
FROM eclipse-temurin:17-jdk-jammy AS build

# Define el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copia los archivos de Maven y el código fuente desde la carpeta 'agenta'
COPY agenta/.mvn/ .mvn
COPY agenta/mvnw agenta/pom.xml ./
RUN ./mvnw dependency:go-offline

COPY agenta/src ./src

# Compila el proyecto y crea el archivo .jar
RUN ./mvnw clean package -DskipTests

# Stage 2: Ejecuta la aplicación usando una imagen de Java Runtime Environment (JRE)
FROM eclipse-temurin:17-jre-jammy

# Define el directorio de trabajo para la ejecución
WORKDIR /app

# Copia el archivo .jar compilado desde la etapa anterior
COPY --from=build /app/target/*.jar ./app.jar

# Expone el puerto por defecto de Spring Boot
EXPOSE 8080

# Comando para iniciar la aplicación
CMD ["java", "-jar", "app.jar"]