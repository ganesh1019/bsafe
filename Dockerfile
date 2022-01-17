FROM openjdk:8-jdk
COPY target/com.simplilearn.bsafe-${env.BUILD_NUMBER}.jar /app/bsafe.jar
EXPOSE 8888
ENTRYPOINT java -Dserver.port=8888 -jar /app/bsafe.jar