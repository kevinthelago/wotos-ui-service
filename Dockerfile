# syntax=docker/dockerfile:1.7

# ---- build ----
FROM eclipse-temurin:17-jdk-jammy AS builder
WORKDIR /workspace

# Cache the dependency layer separately from the source for fast rebuilds.
COPY .mvn/ .mvn/
COPY mvnw pom.xml ./
# Normalise line endings (Windows clones can produce CRLF) and ensure executable.
RUN sed -i 's/\r$//' mvnw && chmod +x mvnw && ./mvnw -B -ntp -Dfrontend.build.skip=true dependency:go-offline

COPY src/ src/
RUN ./mvnw -B -ntp -Dfrontend.build.skip=true -DskipTests clean package \
    && mv target/wotos-ui-service-*.jar target/app.jar

# ---- runtime ----
FROM eclipse-temurin:17-jre-jammy
RUN groupadd --system app && useradd --system --gid app --create-home --home-dir /home/app app
USER app
WORKDIR /home/app

COPY --from=builder /workspace/target/app.jar /home/app/app.jar

EXPOSE 8080
ENTRYPOINT ["java","-jar","/home/app/app.jar"]
