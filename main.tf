provider "aws" {
    region ="us-west-1"   
}

resource "aws_s3_bucket" "dbt_bucket" {
    bucket = "dbt-duckdb-bucket-1"
        tags = {
            name = "dbt-duckdb"
            environment = "Dev"
        }
}