FROM tomcat:9.0.83-jdk8
LABEL "Project"="academy"
LABEL "Author"="Yagnesh"

WORKDIR /usr/local/tomcat/

# Remove existing webapps
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy the war file from Jenkins workspace to Tomcat webapps
COPY target/vprofile-v2.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080
CMD ["catalina.sh", "run"]
