#Public Zone

resource "aws_route53_zone" "primary" {
  name = "teamdelta.com"
}

#Public Subdomain 
resource "aws_route53_zone" "main" {
  name = "teamdelta.com"
}

resource "aws_route53_zone" "dev" {
  name = "dev.teamdelta.com"

  tags = {
    Environment = "dev"
  }
}

resource "aws_route53_record" "dev-ns" {
  zone_id = aws_route53_zone.main.zone_id
  name    = "dev.teamdelta.com"
  type    = "NS"
  ttl     = "30"
  records = aws_route53_zone.dev.name_servers
}