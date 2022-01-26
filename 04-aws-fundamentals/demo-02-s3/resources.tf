resource "aws_s3_bucket" "koala-bucket" {
  bucket_prefix = "koalacampaign"
}

resource "aws_s3_bucket_object" "pics" {
  bucket   = aws_s3_bucket.koala-bucket.id
  for_each = var.files
  key      = each.key
  source   = "./pics/${each.value}"
}

resource "aws_s3_bucket_object" "folder" {
  bucket = aws_s3_bucket.koala-bucket.id
  key    = "archive/koalazzz.jpg"
  source = "./pics/koalazzz.jpg"
}