resource "aws_s3_bucket" "resources" {
  bucket = "config.${data.aws_route53_zone.region_zone.name}"
  acl    = "private"

  versioning {
    enabled = true
  }

  website {
    index_document = "index.html"
    error_document = "/error.html"
  }

  tags {
    Name     = "kuberform-resources-${data.aws_region.current.name}"
    Owner    = "infrastructure"
    Billing  = "costcenter"
    Role     = "configuration_bucket"
    Provider = "https://github.com/kuberform"
  }
}

resource "aws_route53_record" "resources" {
  zone_id = "${data.aws_route53_zone.region_zone.zone_id}"
  name    = "config.${data.aws_route53_zone.region_zone.name}"
  type    = "A"

  alias {
    name    = "${aws_s3_bucket.resources.website_domain }"
    zone_id = "${aws_s3_bucket.resources.hosted_zone_id }"
  }
}
