# Spring Boot Hello World Example Project.
# deploying simple java app by shell script on tomcat

- check is user a root user.
- apt-get update
- apt-get install maven
- mvn test
- mvn package
- apt-get install tomcat9
- cp -rvf target/hello-world-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/app.war
