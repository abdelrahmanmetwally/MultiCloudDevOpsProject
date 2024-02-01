resource "aws_s3_bucket" "remote" {
  bucket = "ivolve-free-project"
  lifecycle {
    prevent_destroy = false

    }


}


resource "aws_s3_bucket_versioning" "backend" {
  bucket = aws_s3_bucket.remote.id
  versioning_configuration {
    status = "Enabled"
  }
}

# resource "aws_dynamodb_table" "backend-dynamodb" {
#   name           = "backend-dynamo"
#   billing_mode   = "PAY_PER_REQUEST"
#   hash_key       = "LockID"


#   attribute {
#     name = "LockID"
#     type = "S"
#   }
# }





terraform {
  backend "s3" {
    bucket = "ivolve-free-project"
    key= "devops/terraform.tfstate"
    region="us-east-1"

     # dynamodb_table = "backend-dynamo"
    encrypt = true

  }
}

