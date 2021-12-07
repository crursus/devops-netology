FROM ubuntu:latest

ADD https://pkg.jenkins.io/redhat-stable/jenkins.repo /

#ENV TZ=Europe/Moscow

RUN apt-get update && apt-get install -yy tzdata
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt install wget -y
RUN apt-get install gnupg -y
RUN wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
RUN echo "deb https://pkg.jenkins.io/debian binary/" >> /etc/apt/sources.list
RUN apt-get update
RUN apt-get install jenkins -y
RUN apt install openjdk-11-jdk -y

EXPOSE 8080
#EXPOSE 50000

CMD ["/bin/bash"]


ENTRYPOINT ["/usr/share/jenkins/"]
