FROM openjdk:8-jdk
COPY target/com.simplilearn.bsafe-{$BUILD_NUMBER}.jar /app/bsafe.jar
EXPOSE 8888
ENTRYPOINT java -Dserver.port=8888 -jar /app/bsafe.jar