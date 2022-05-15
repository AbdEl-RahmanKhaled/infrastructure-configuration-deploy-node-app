pipeline {
    agent any

    environment {
        env = "prod"
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
                        sh 'terraform -chdir=terraform/ taint null_resource.out'
                        sh 'terraform -chdir=terraform/ init -migrate-state'
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
                        sh 'terraform '
                        sh 'terraform -chdir=terraform/ apply --var-file ${env}.tfvars -auto-approve'
                    }
               }
            }
        }
    }
}
