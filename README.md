# Infrastructure, Configuration and Deployment Automation

In this project we will:

* Bulid infrastructure on [AWS](https://aws.amazon.com/) using [Terraform](https://www.terraform.io/)
* Configure the environment using [Ansible](https://www.ansible.com/)
* Build simple node.js app using [Docker](https://www.docker.com/)
* Integrate all these tools with each other and build a pipelines using [Jenkins](https://www.jenkins.io/) to setup infrastructure and deploy a simple node.js [App](https://github.com/AbdEl-RahmanKhaled/jenkins_nodejs_example/tree/rds_redis) on
    * Docker on private EC2
    * Amazon Elastic Kubernetes Service (EKS) cluste

# Tools Used

<p align="center">
<a href="https://www.terraform.io/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/terraform/terraform-original-wordmark.svg" alt="terraform" width="40" height="40"/> </a> <a href="https://www.ansible.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/ansible/ansible-original-wordmark.svg" alt="ansible" width="40" height="40"/> </a>  <a href="https://aws.amazon.com" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/amazonwebservices/amazonwebservices-original-wordmark.svg" alt="aws" width="40" height="40"/> </a> <a href="https://www.gnu.org/software/bash/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/bash/bash-original.svg" alt="bash" width="40" height="40"/> </a> <a href="https://www.docker.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/docker/docker-original-wordmark.svg" alt="docker" width="40" height="40"/> </a> <a href="https://www.jenkins.io" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/jenkins/jenkins-original.svg" alt="jenkins" width="40" height="40"/> </a> <a href="https://kubernetes.io" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/AbdEl-RahmanKhaled/AbdEl-RahmanKhaled/main/icons/kubernetes/kubernetes-icon.svg" alt="kubernetes" width="40" height="40"/> </a> 
</p>

# Prerequisites

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

# Get Started
## Infra Pipeline

### On AWS 
* Create IAM user for Jenkins with `Programmatic access` 
* Create S3 bucket in `eu-west-1` for statfile of terraform
* Change the `bucket` value in `terraform/backend.tf` file with the new one
* Create `DynamoDB` with name `"terraform-lock"` with one field named `"LockID"`

### On Jenkins

* Add IAM user to Jenkins under `Manage Jenkins > Manage Credentials > Add Credentials` and configure it's type to be `AWS Credentials` name it `"jenkins_aws"`

    ![aws_cred](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/infrastructure-configuration-deploy-node-app/master/imgs/aws_cred.png)

* Install `"Pipeline: AWS Steps"` and `"Terraform Plugin"` plugins from `Manage Jenkins > Manage Plugins`

* Configure Terraform Plugin from "Manage Jenkins > Global Tool Configuration" under Terraform section 
    
    * Set Name >  `"tf"`
    * check `Install automatically`
    * Set Version `Terraform >= 30413 linux (amd64)`

* Create preferred RDS credentials `Username and Password` to Jenkins under `Manage Jenkins > Manage Credentials > Add Credentials` and name it with `rds_cred`

* Create pipeline and add your repo link

    ![pipeline](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/infrastructure-configuration-deploy-node-app/master/imgs/pipeline.png)

* Push the changes

* Trigger the pipeline to build the infrastructure and configure the environment 

* After the pipeline is finished it will:

    * Create the following structure with Terrafom

        ![infra](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/infrastructure-configuration-deploy-node-app/master/imgs/AWS-infra.png)

    * Configure Jenkins server to access the private instance through the bastion server by write `config` file under ~/.ssh

    * Write the inventory file for Ansible

    * Write `.env` file with the evironment variables for our App

    * Add and set permissions to the private key for accessing instances. Under ~/.ssh you will find file named `key.pem`

    * Configure the private instance to be ready to deploy our app using Ansible, it will:
    
        * Install Docker, Java, ZIP, kubectl, aws cli
        * Copy `.env` file to the server 
        * Copy `ansible/files/agent.jar` to the server to configure the server as an agent for Jenkins

* Now, configure the private instance as an agent for Jenkins. From `Manage jenkins > Manage nodes and clouds > New Node` and configure it as below 
   
    ![agent](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/infrastructure-configuration-deploy-node-app/master/imgs/slave.png)


## Build & Deploy Pipeline

We will use this simple node.js [App](https://github.com/AbdEl-RahmanKhaled/jenkins_nodejs_example/tree/rds_redis) to deploy on our infra.

* Fork and clone the [Repo](https://github.com/AbdEl-RahmanKhaled/jenkins_nodejs_example/tree/rds_redis) `rds_redis` branch

* Replace `IMG_NAME` value with your repo on [DockerHub](https://hub.docker.com/) in 
    * `Jenkinsfile` 
    * `Jenkinsfile_kube`

* Add DockerHub credentials to Jenkins under `Manage Jenkins > Manage Credentials > Add Credentials` and name it with `docker-hub`

* Push the changes to `rds_redis` branch

* Create new pipleline with the forked repo

    `Must choose "rds_redis" branch` 

    ![app pipeline](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/infrastructure-configuration-deploy-node-app/master/imgs/app-pipeline.png)

* Use 
    * `Jenkinsfile` to deploy on the private EC2

        ![jenkinsfile](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/infrastructure-configuration-deploy-node-app/master/imgs/jenkins.png)

    * `Jenkinsfile_kube` to deploy on EKS cluster

        ![jenkinsfile](https://raw.githubusercontent.com/AbdEl-RahmanKhaled/infrastructure-configuration-deploy-node-app/master/imgs/jenkins_kube.png)

* Trigger the pipeline to deploy the App

Finally, you can access the deployed app from created `Load Balancer` URL and check the Database, Redis connectivity by hitting `/db` and `/redis` from your browser.

```bash
# NOTE
if you want to access the app deployed on `private EC2` use the `app-lb` load balancer `DNS name`
else use the `DNS name` of the other load balancer
```









