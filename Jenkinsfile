pipeline {
    agent any

    environment {
        deploy_env = "prod"
    }

    tools {
        terraform "tf"
    }

    stages {
        stage('init tf') {
           steps {
               script {
                    echo 'initializing terraform ...'
                    withAWS(credentials: 'jenkins_aws') {
                        sh 'terraform -chdir=terraform/ init -migrate-state'
                    }
               }
           }
       }
       stage('apply infra') {
           steps {
               script {
                    echo 'deploying image....'
                    sh 'chmod +x scripts/inv-file.sh'
                    sh 'chmod +x scripts/config-file.sh'
                    sh 'chmod +x scripts/env-file.sh'
                    withAWS(credentials: 'jenkins_aws') {
                        // sh 'terraform -chdir=terraform/ taint null_resource.out'
                        withCredentials([usernamePassword(credentialsId: 'rds_cred', usernameVariable: 'TF_VAR_rds_password', passwordVariable: 'PASS')]) {
                            sh "terraform -chdir=terraform/ apply --var-file ${deploy_env}.tfvars -auto-approve"
                        }
                    }
               }
            }
        }
        stage('configure') {
           steps {
               script {
                    echo 'deploying image....'
                    sh 'ansible-playbook ansible/playbook.yaml -i ansible/inventory'
               }
            }
        }
    }
}
