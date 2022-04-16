terraform {
  backend "s3" {
    bucket         = "terraform-course-a-kha"
    key            = "state-file/"
    region         = "eu-west-1"
    dynamodb_table = "terraform-lock"
    profile = "default"
  }
}
