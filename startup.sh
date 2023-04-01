#!/bin/bash

#######################################
#################V1####################
###########JENKINS SCRIPT##############

###Author = latesh sharma##


###############FUNCTIONS#################

function installPackage() {
    local PackageName=${1}  # by local we can convert our environment variable to local 
    apt-get install -y ${PackageName}
    if [[ $? == 0 ]]  
    then
        echo "${PackageName} install sucessfull"
    else  
        echo -e "\033[0;31m E: not able to install the ${PackageName}"
        exit 1
    fi
}


function mavenTargate() {
    local Maven=${1}
    mvn ${Maven}
    if [[ $? != 0 ]] 
    then 
        echo -e "\033[0;31m E: mvn ${Maven} unsucessfull"
        exit 1
    fi
}


#################VARIABLES###############

if [[ $UID != 0 ]] # UID of root user is 0
then
    echo -e  "\033[0;31m E:  user is not root user"
    exit 1         # we  used exit 1 because (exit 0 ) means sucess.
fi

apt-get update

if [[ $? != 0 ]]   # here, $? shows the exit staus of last command (0 means sucess)
then
    echo -e "\033[0;31m E: not able to update the repository"
    exit 1
fi

installPackage maven          # function call
installPackage tomcat9
mavenTargate test
mavenTargate package


cp -rvf target/hello-world-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/app.war

if [[ $? == 0 ]] 
then
    echo ".war deploy sucessfull"
else
    echo -e "\033[0;31m E: .war unsucessfull"
    exit 1
fi

