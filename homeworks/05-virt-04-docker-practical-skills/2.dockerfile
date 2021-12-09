FROM ubuntu:latest

ADD https://pkg.jenkins.io/debian-stable/jenkins.io.key /

RUN apt update && apt install -y openjdk-11-jdk
RUN apt install -y gnupg
RUN apt-key add /jenkins.io.key
RUN echo "deb https://pkg.jenkins.io/debian-stable binary/" > /etc/apt/sources.list.d/jenkins.list
RUN apt update && apt install -y jenkins

EXPOSE 8080
#EXPOSE 50000

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
