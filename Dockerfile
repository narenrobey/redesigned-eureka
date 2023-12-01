FROM gradle:8.4-jdk17 as builder
WORKDIR /opt

ADD src/ src/
COPY build.gradle .
COPY settings.gradle .

RUN gradle bootJar

FROM eclipse-temurin:17-jre-focal as runner

RUN apt-get update && apt-get install -y \
    tini \
    && rm -rf /var/lib/apt/lists/*

COPY --from=builder /opt/build/libs/tfrunner-0.0.1-SNAPSHOT.jar /opt/tfrunner.jar
ENTRYPOINT ["tini", "--"]

CMD ["java","-jar","/opt/tfrunner.jar"]