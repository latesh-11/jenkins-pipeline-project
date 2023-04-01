#!/bin/bash

#######################################
#                V2                   #
#             IMPROVED SYNTEX         #
###########JENKINS SCRIPT##############

###Author = latesh sharma##


###############FUNCTIONS#################

function installPackage() {
    local PackageName=${1}  # by local we can convert our environment variable to local 
    if  apt-get install -y ${PackageName}
    then
        echo "${PackageName} install sucessfull"
    else  
        echo -e "\033[0;31m] E: not able to install the ${PackageName}"
        exit 1
    fi
}


function mavenTargate() {
    local Maven=${1}
    if ! mvn ${Maven}
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

read -p "please enter access path: " App_Context
App_Context=${App_Context:-app}     # default value 


if ! apt-get update
then
    echo -e "\033[0;31m E: not able to update the repository"
    exit 1
fi

installPackage maven          # function call
installPackage tomcat9
mavenTargate test
mavenTargate package

#####DEPLOYMENT ZONE#########

if cp -rvf target/hello-world-0.0.1-SNAPSHOT.war /var/lib/tomcat9/webapps/${App_Context}.war
then
    echo "application deployed sucessfully you can access it on http://<IPADDRESS>:8080/${App_Context}"
else
    echo -e "\033[0;31m E: .war unsucessfull"
    exit 1
fi
exit 0

 