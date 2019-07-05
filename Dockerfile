# Stage 1 (to create a "build" image, ~140MB)
FROM openjdk:8-jdk-alpine AS builder
RUN java -version

COPY . /usr/src/myapp/
WORKDIR /usr/src/myapp/
RUN apk --no-cache add maven && mvn --version
RUN mvn install

# Stage 2 (to create a downsized "container executable", ~87MB)
FROM openjdk:8-jre-alpine
WORKDIR /root/
COPY --from=builder /usr/src/myapp/target/app.jar .

RUN apk add util-linux pciutils usbutils coreutils binutils findutils grep

ENTRYPOINT ["sleep 30s", "&&", "java", "-jar", "./app.jar"]