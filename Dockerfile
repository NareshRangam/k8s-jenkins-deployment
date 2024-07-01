FROM openjdk:17
WORKDIR /appContainer
COPY ./target/kubernetes-simple-app.jar /appContainer
EXPOSE 9112
CMD ["java","-jar","kubernetes-simple-app.jar"]