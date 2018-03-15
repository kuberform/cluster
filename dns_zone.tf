variable "zone_id_map" {
  type        = "map"
  description = "Map data from module.kuberform.dns_zone.region_zones."
}

data "aws_route53_zone" "region_zone" {
  zone_id = "${var.zone_id_map[data.aws_region.current.name]}"
}
