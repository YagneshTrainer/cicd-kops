FROM rockylinux:8

MAINTAINER hello@gritfy.com

RUN mkdir /opt/tomcat/

WORKDIR /opt/tomcat

RUN curl -o apache-tomcat.tar.gz https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.79/bin/apache-tomcat-9.0.79.tar.gz
RUN tar xvzf apache-tomcat.tar.gz
RUN mv apache-tomcat-9.0.79/* /opt/tomcat/.
RUN yum -y install java
RUN java -version

WORKDIR /opt/tomcat
RUN rm -rf /opt/tomcat/webapps/*
COPY target/vprofile-v2.war /opt/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["/opt/tomcat/bin/catalina.sh", "run"]
