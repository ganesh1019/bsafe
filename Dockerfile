FROM openjdk:8
RUN java -Dserver.port=8888 -jar target/com.simplilearn.bsafe-{$BUILD_NUMBER}.jar
EXPOSE 8888