# MultiCloudDevOpsProject

## Ci/Cd pipeline project
# Description: 
 creating a small application passing through different stages of ci/cd starting from pushing commits on github , making a unit test , building and pushing docker images of the app , analysing it using sonarqube till deploying it in openshift.

 ## Requirements: 
 - terraform : used terraform modules to build and provision simple infrastructure like: vpc,ec2,security group,route table,backend for terraform.   
 - ansible: using ansible roles to manage the remote servers and install required tools.
 - jenkins: to run ci/cd pipeline and automate the process and using jenkins shared libraries to make Jenkinsfile it sharable and more reusable
    ,,you can find the repo of used shared library at https://github.com/abdelrahmanmetwally/my-jenkins-shared-library.git
 - sonarqube: to check code quality.
 - monitoring and logging on opneshift: using red hat openshift logging and openshift elastic operators .
 - monitoring the infrasturcture: used terraform to integrate cloud watch with the ec2 , find it in (terraform-modules-project/ec2/m.ain.tf).
 - aws: the cloud provider which we will create and manage the remote machine in.
 -  github
## to run the deployment script: 
```
    chmod +x run.sh
   ./run.sh
```
