# build da aplicação com maven
FROM maven:4.0.0-rc-5-eclipse-temurin-25 AS build
WORKDIR /app

# copia dependências
COPY pom.xml .
RUN mvn dependency:go-offline -B

# copia o código e faz a build do package
COPY src ./src
RUN mvn clean package -DskipTests

# cria a imagem docker sem maven
FROM eclipse-temurin:25-jre-alpine
WORKDIR /app

# copia só o .jar da build
COPY --from=build /app/target/*.jar app.jar

# expõe a porta 8080
EXPOSE 8080

# termos usados pra executar app
ENTRYPOINT ["java", "-jar", "app.jar"]