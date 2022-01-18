FROM amazoncorretto

ADD https://pkg.jenkins.io/redhat-stable/jenkins.repo /etc/yum.repos.d/
RUN amazon-linux-extras install epel -y
RUN rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key && yum install -y jenkins

EXPOSE 8080
#EXPOSE 50000

CMD ["java", "-jar", "/usr/share/jenkins/jenkins.war"]
