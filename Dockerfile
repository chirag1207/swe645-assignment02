FROM tomcat:9.0-jdk11
COPY surveyformPart2.war /usr/local/tomcat/webapps
Expose 8080
