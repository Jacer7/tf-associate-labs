#############################################
          # BLOCK 1: Terraform
#############################################
terraform {
  required_version = ">= 1.12.0" # Terraform Version
  required_providers {
    aws = {
      source  = "hashicorp/aws" # constraint to cli installed in the laptop, it is not aws cli, it is Terraform that downloads at .terraform/providers
      version = "~> 6.0" # not 7.0 but could be 6.1, 6.2 ...till 6.9, simply 6.X
    }
    random = {
      source  = "hashicorp/random" # Hashicorp tiny plugin that generates random values
      version = "~> 3.6" # means 3.6 and up but not 4.0
    }
  }
}

#############################################
# Block 2: PROVIDER 
#############################################
provider "aws" {
  region  = "eu-west-3"
  profile = "tf-lab"    # ~/.aws/credentials under [tf-lab]
}

#############################################
# Block 3: Random ID to Get Rand no 
#############################################
resource "random_id" "suffix" {
  byte_length = 4
}

#############################################
# Block 4: Resource - AWS S3 BUCKET 
#############################################
resource "aws_s3_bucket" "lab" {
  bucket = "tf-lab01-${random_id.suffix.hex}"

  tags = {
    Project = "tf-associate"
    Lab     = "01"
    Owner   = "Jacer"
  }
}

#############################################
# Block 5: OUTPUT DISPLAYED IN CLI 
#############################################
output "bucket_name" {
  value = aws_s3_bucket.lab.bucket
}