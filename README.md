# Infrastructure and Configuration

In this project we will:

* Bulid infrastructure on [AWS](https://aws.amazon.com/) using [Terraform](https://www.terraform.io/)
* Configure the environment using [Ansible](https://www.ansible.com/)
* Build our app using [Docker](https://www.docker.com/)
* Integrate all these tools with each other and build a pipeline using [Jenkins](https://www.jenkins.io/) to deploy our app

## Tools Used

<p align="center">
<a href="https://www.terraform.io/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/terraform/terraform-original-wordmark.svg" alt="terraform" width="40" height="40"/> </a> <a href="https://www.ansible.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/ansible/ansible-original-wordmark.svg" alt="ansible" width="40" height="40"/> </a>  <a href="https://aws.amazon.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/amazonwebservices/amazonwebservices-original-wordmark.svg" alt="aws" width="40" height="40"/> </a> <a href="https://www.gnu.org/software/bash/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/bash/bash-original.svg" alt="bash" width="40" height="40"/> </a> <a href="https://www.docker.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/docker/docker-original-wordmark.svg" alt="docker" width="40" height="40"/> </a> <a href="https://www.jenkins.io" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/jenkins/jenkins-original.svg" alt="jenkins" width="40" height="40"/> </a> 
</p>

## Prerequisites

* Fork the repository

* Clone the project
    
    ```git
    git clone https://github.com/<USERNAME>/infrastructure-configuration-deploy-node-app.git
    ```

* [Docker](https://docs.docker.com/desktop/linux/install/) installed in your system, you can directly run:

    ```bash
    sudo apt update && sudo apt install docker.io
    ```
* Jenkins image with docker client. You can use my Dockerfile in helper-files/jenkins_docker, just run
    
    ```bash
    cd helper-files/
    docker build -f jenkins_docker . -t jenkins_docker:lts
    ```
    After the build finish, run the image and mount docker deamon by

    ```bash
    docker run -d --name jenkins -p 8080:8080 -v jenkins_home:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock jenkins_docker:lts
    ```
    Now you can access the jenkins server from http://localhost:8080

## Get Started

### On AWS 

* Create IAM user for Jenkins with "Programmatic access" 
* Create S3 bucket in "eu-west-1" for statfile of terraform
* Change the "bucket" value in "terraform/backend.tf" file with the new one
* create "DynamoDB" with name "terraform-lock" with one field named "LockID" 

### On Jenkins

* Add IAM user to Jenkins under "Manage Jenkins > Manage Credentials > Add Credentials" and configure it's type to be "AWS Credentials" name it "jenkins_aws" 

    ![aws_cred]()

* Install "Pipeline: AWS Steps" and "Terraform Plugin" plugins from "Manage Jenkins > Manage Plugins"

* Configure Terraform Plugin from "Manage Jenkins > Global Tool Configuration" under Terraform section 
    
    * Set Name > tf
    * check "Install automatically"
    * Set Version "Terraform >= 30413 linux (amd64)"

* Push the changes and add your repo link

* Trigger the pipeline to build the infrastructure and configure the environment. After the pipeline finish will create the following structure

    ![infra]()






