---
title: Securing Pi access using CloudFlare
layout: post
---

I've recently been building an environment monitoring station at home using a Raspberry Pi 4B+. It turns out to be a remarkably powerful computer, much more than I remembered from earlier versions. I'll write more another time about the environment side of things, but today I'm going to focus on how awesome the UX is when putting it behind Cloudflare.

This is the first time I've used Cloudflare for more than DNS, and it's remarkable how much you can do for free. When I SSH to `pi.46bit.cloud`, I get redirected to a browser page to sign in – either with a one-time password emailed to me, or via Google OAuth. Only once that's done can I actually finish SSHing. Cloudflare hides my actual home IP address and adds a strong boundary around accessing services externalyl.

You have to be hosting your DNS with Cloudflare for this to work. Once that's done there are two parts to this:

1. **Connecting your host to Cloudflare:** [Argo Tunnel](https://www.cloudflare.com/products/tunnel/) connection outbound from my Pi to Cloudflare. This acts as a reverse proxy. Cloudflare forwards authenticated traffic to the Pi through this
2. **Setup inside Cloudflare:** A DNS entry pointing to a hostname identifying that tunnel, and then a [Cloudflare Access](https://www.cloudflare.com/teams/access/) app telling Cloudflare what authentication to require.

The first half of this, setting up Argo Tunnel, is manual sysadmin on your Pi (or YAML engineering if you're forwarding to a cluster or something.) Cloudflare provide [good instructions on setting up the tunnel](https://developers.cloudflare.com/cloudflare-one/connections/connect-apps/install-and-setup/tunnel-guide).

The second half can be done in Cloudflare's web interface but I found that a lot of clicking around. A lot of this is exposed in their interface in two different places, making setup difficult. It's easier to configure it with Terraform, which looks like this:

```terraform
variable "cloudflare_account_id" {
  description = "Provide your Cloudflare account ID (a 20-ish character string)"
}

resource "cloudflare_zone" "_46bit_cloud" {
  zone = "46bit.cloud"
  plan = "free"
}

resource "cloudflare_record" "pi" {
  zone_id = cloudflare_zone._46bit_cloud.id
  type    = "CNAME"
  proxied = true

  name  = "pi"
  value = "77030280-fb2a-4b9a-bf5d-d6ebddca53e9.cfargotunnel.com"
}

resource "cloudflare_access_application" "pi" {
  name = "pi"
  account_id = var.cloudflare_account_id

  domain           = "pi.46bit.cloud"
  type             = "ssh"
  session_duration = "24h"

  auto_redirect_to_identity = true
}

resource "cloudflare_access_policy" "pi_email" {
  name = "Pi SSH access via email"
  account_id = var.cloudflare_account_id

  application_id = cloudflare_access_application.pi.id
  precedence = "1"
  decision   = "allow"

  include {
    email_domain = ["46b.it", "46bit.com"]
  }
}

```
