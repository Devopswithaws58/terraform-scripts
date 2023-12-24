resource "aws_s3_bucket" "s3bucket" {
  bucket = "s3bucket-99"
  tags = {
    Name = "s3bucket-99"
  }
}
