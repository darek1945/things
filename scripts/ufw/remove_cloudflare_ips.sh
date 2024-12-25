#!/bin/bash

# Fetch current IPv4 addresses from Cloudflare
ipv4_addresses=$(curl -s https://www.cloudflare.com/ips-v4)

# Fetch current IPv6 addresses from Cloudflare
ipv6_addresses=$(curl -s https://www.cloudflare.com/ips-v6)

# Remove rules for IPv4
echo "Removing IPv4 rules for Cloudflare..."
for ip in $ipv4_addresses; do
  ufw delete allow from $ip to any port 80 proto tcp
  ufw delete allow from $ip to any port 443 proto tcp
done

# Remove rules for IPv6
echo "Removing IPv6 rules for Cloudflare..."
for ip in $ipv6_addresses; do
  ufw delete allow from $ip to any port 80 proto tcp
  ufw delete allow from $ip to any port 443 proto tcp
done

echo "Finished removing rules for Cloudflare."

# Display UFW status
ufw status numbered
