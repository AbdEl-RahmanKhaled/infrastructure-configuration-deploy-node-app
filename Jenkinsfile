pipeline {
    agent any

    environment {
        env: "prod"
    }

    tools {
        terraform "tf"
    }

    stages {
        stage('init tf') {
           steps {
                echo 'initializing terraform ...'
                withAWS(credentials: 'jenkins_aws') {
                    sh 'cd terraform/'
                    sh 'terraform init -migrate-state'
                }
           }
       }
       stage('apply infra') {
           steps {
               script {
                    echo 'deploying image....'
                    withAWS(credentials: 'jenkins_aws') {
                    sh 'terraform apply --var-file ${env}.tfvars'
                    }
               }
            }
        }
    //    stage('Push to Dockerhub'){
    //        steps {
    //            echo 'pushing to dockerhub repo...'
    //             withCredentials([usernamePassword(credentialsId: 'docker-hub', usernameVariable: 'USERNAME', passwordVariable: 'PASS')]) {
    //                 sh 'echo $PASS | docker login -u $USERNAME --password-stdin'
    //                 sh "docker push ${IMG_NAME}:${NEW_TAG}"
    //             }
    //        }

    //        post {
    //             success {
    //                 slackSend(channel: "test", message: "test", sendAsText: true)
    //             }
    //         }
    //    }
       
    }
}
