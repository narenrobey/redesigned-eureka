FROM maven:3.9-amazoncorretto-17

WORKDIR /src
COPY /src .
COPY pom.xml .

RUN mvn test