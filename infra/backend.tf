terraform {
    backend "s3" {
        bucket = "terraform-try-app-runner-tfstate"
        key    = "terraform.tfstate"
        region = "ap-northeast-1"
    }
}

provider "aws" {
  region = "ap-northeast-1"
}
  