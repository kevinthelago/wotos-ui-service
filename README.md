# WoToS UI Service

Spring Boot service in the [WoToS](https://github.com/users/kevinthelago/projects/2) system. Its sole responsibility is to build the `wotos-react-ui` React application and serve the compiled output as static files via Thymeleaf.

The `frontend-maven-plugin` downloads Node.js 18.8.0 and Yarn 1.22.17 automatically during the Maven build — no local Node installation is required.

## Prerequisites

- Java 17 (Temurin recommended)
- Maven or the included `./mvnw` wrapper
- The `wotos-react-ui` source must be present alongside this repo (the plugin expects it at `./wotos-react-ui/`)

## Building and Running

```bash
# Full build: installs JS deps, compiles React, packages JAR
./mvnw clean package

# Run the packaged service
./mvnw spring-boot:run
```

The compiled React app is available at `http://localhost:8080` once the service is running.

## How the Frontend Build Works

1. `frontend-maven-plugin` runs `yarn install` inside `wotos-react-ui/`.
2. It then runs `npm run build`, producing a `build/` directory.
3. The Maven build copies `build/` to `target/classes/static/`.
4. Spring Boot serves the static files; Thymeleaf maps `/` to `index.html`.

## Development

For active UI development, run `wotos-react-ui` standalone (`npm start`) rather than rebuilding through this service on every change.

## Docker

The repo ships a multi-stage `Dockerfile` that builds the backend with the JDK and ships the executable jar on a slim JRE. The image **does not include the compiled React app** — `wotos-react-ui` lives in a sibling repo and is composed in at the project-root level (see Phase 5/8 roadmap items).

```bash
# Build
docker build -t wotos-ui-service:dev .

# Run
docker run --rm -p 8080:8080 wotos-ui-service:dev
```

The service listens on `8080`. Without a running Spring Cloud Config server or Eureka registry, the optional config-import + Eureka client degrade gracefully — Spring Boot reports `Started WotosUiServiceApplication` and the process keeps running.
