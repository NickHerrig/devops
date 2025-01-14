resource "digitalocean_droplet" "jamql" {
  image    = "ubuntu-20-04-x64"
  name     = "jamql"
  region   = "nyc1"
  size     = "s-1vcpu-1gb"
  ssh_keys = [
    digitalocean_ssh_key.andrew.fingerprint,
    digitalocean_ssh_key.nick.fingerprint,
  ]
}

resource "digitalocean_domain" "jamql" {
  name       = "jamql.com"
  ip_address = digitalocean_droplet.jamql.ipv4_address
}

resource "digitalocean_record" "jamql_caa_letsencrypt" {
  domain = digitalocean_domain.jamql.name
  name   = "@"
  type   = "CAA"
  value  = "letsencrypt.org."
  flags  = "0"
  tag    = "issue"
  ttl    = "3600"
}
