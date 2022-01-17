FROM openjdk:8-jdk
COPY target/com.simplilearn.bsafe-latest.jar /app/bsafe.jar
EXPOSE 8888
RUN java -Dserver.port=8888 -jar /app/bsafe.jar