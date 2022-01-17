# use a node base image
FROM openjdk:8

# set maintainer
LABEL maintainer "ganeshr@live.in"

# set a health check
RUN ["java","-Dserver.port=8888 -jar target/com.simplilearn.bsafe-{$BUILD_NUMBER}.jar"]

# tell docker what port to expose
EXPOSE 8888