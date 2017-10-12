FROM maven:3-jdk-8 AS appserver
WORKDIR /usr/src/app-ws
COPY . .
RUN mvn -B -s /usr/share/maven/ref/settings-docker.xml package -DskipTests

FROM openjdk:jre-alpine
RUN apk update && apk add ca-certificates openssl curl && rm -rf /var/cache/apk/*

WORKDIR /usr/lib/jvm/java-1.8-openjdk/jre/lib/security/
RUN wget https://bin.gov.pf/artifactory/public/jce/local_policy.jar -O local_policy.jar
RUN wget https://bin.gov.pf/artifactory/public/jce/US_export_policy.jar -O US_export_policy.jar

WORKDIR /app
COPY --from=appserver /usr/src/app-ws/target/config-service-0.1.0.jar app.jar
ENV JAVA_OPTS=""
ENTRYPOINT exec java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app/app.jar
