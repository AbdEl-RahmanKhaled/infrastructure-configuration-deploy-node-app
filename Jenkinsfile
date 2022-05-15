pipeline {
    agent any

    environment {
        env = "prod"
    }

    tools {
        terraform "tf"
        org.jenkinsci.plugins.ansible.AnsibleInstallation "ans"
    }

    stages {
        stage('init tf') {
           steps {
               script {
                    echo 'initializing terraform ...'
                    withAWS(credentials: 'jenkins_aws') {
                        sh 'terraform -chdir=terraform/ taint null_resource.out'
                    }
               }
           }
       }
       stage('apply infra') {
           steps {
               script {
                    echo 'deploying image....'
                    sh 'chmod +x scripts/key-dir.sh'
                    sh './scripts/key-dir.sh'
                    withAWS(credentials: 'jenkins_aws') {
                        sh 'terraform -chdir=terraform/ init -migrate-state'
                        sh 'terraform -chdir=terraform/ apply --var-file ${env}.tfvars -auto-approve'
                    }
               }
            }
        }
        stage('configure') {
           steps {
               script {
                    echo 'deploying image....'
                    sh 'ansible private -i /ansible/inventory -m ping --private-key=key/key.pem'
               }
            }
        }
    }
}
