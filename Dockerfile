FROM openjdk:17
WORKDIR /appContainer
COPY ./target/kubernetes-simpleapp.jar /appContainer
EXPOSE 9112
CMD ["java","-jar","kubernetes-simpleapp.jar"]