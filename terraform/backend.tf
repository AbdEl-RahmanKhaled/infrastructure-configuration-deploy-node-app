terraform {
  backend "s3" {
    bucket         = "jenkins-pipline"
    key            = "tf-state-file"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
    profile = "default"
  }
}
