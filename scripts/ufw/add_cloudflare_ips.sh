#!/bin/bash

# Fetch current IPv4 addresses from Cloudflare
ipv4_addresses=$(curl -s https://www.cloudflare.com/ips-v4)

# Fetch current IPv6 addresses from Cloudflare
ipv6_addresses=$(curl -s https://www.cloudflare.com/ips-v6)

# Add rules for IPv4
echo "Adding IPv4 rules for Cloudflare..."
for ip in $ipv4_addresses; do
  ufw allow from $ip to any port 80 proto tcp
  ufw allow from $ip to any port 443 proto tcp
done

# Add rules for IPv6
echo "Adding IPv6 rules for Cloudflare..."
for ip in $ipv6_addresses; do
  ufw allow from $ip to any port 80 proto tcp
  ufw allow from $ip to any port 443 proto tcp
done

echo "Finished adding rules for Cloudflare."

# Enable UFW if it is not already active
if ! ufw status | grep -q "Status: active"; then
  echo "UFW is not active. Enabling UFW..."
  ufw enable
fi

# Display UFW status
ufw status numbered
