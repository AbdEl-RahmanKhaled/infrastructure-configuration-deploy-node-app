pipeline {
    agent any

    tools {
        
        terraform "tf"
    }

    stages {

        stage('init') {
           steps {
                echo 'initializing terraform ...'
                withAWS(credentials: 'jenkins_aws') {
                    sh 'terraform init'
                }
           }
       }
       stage('plan') {
           steps {
               script {
                    echo 'deploying image....'
                    withAWS(credentials: 'jenkins_aws') {
                    sh 'terraform plan --var-file prod.tfvars'
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
