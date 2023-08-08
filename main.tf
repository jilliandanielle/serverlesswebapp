provider "aws" {
  region = "eu-west-2" 
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-bucket"
  acl    = "private"

  website {
    index_document = "index.html"
    error_document = "error.html"
  }
}
