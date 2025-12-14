# Function to run command with retries (for network operations)
run_with_retry() {
    local max_attempts=3
    local attempt=1
    local cmd="$*"
    
    while [ $attempt -le $max_attempts ]; do
        if eval "$cmd" 2>&1; then
            return 0
        fi
        
        if [ $attempt -lt $max_attempts ]; then
            echo "Failed, retrying in 5 seconds..."
            sleep 5
        fi
        attempt=$((attempt + 1))
    done
    
    echo "ERROR: Failed after $max_attempts attempts: $cmd"
    return 1
}

# Install printing stack with paru (better for VMs and network issues)
run_with_retry "sudo pacman -S --needed --noconfirm cups cups-filters avahi nss-mdns"

# Enable services
sudo systemctl enable --now cups.service
sudo systemctl enable --now avahi-daemon.service
sudo systemctl enable --now cups-browsed.service

# Disable multicast DNS in systemd-resolved (Avahi will handle this)
sudo mkdir -p /etc/systemd/resolved.conf.d
printf '[Resolve]\nMulticastDNS=no\n' | sudo tee /etc/systemd/resolved.conf.d/10-disable-multicast.conf >/dev/null

# Enable mDNS resolution for .local domains
sudo sed -i 's/^hosts:.*/hosts: mymachines mdns_minimal [NOTFOUND=return] resolve files myhostname dns/' /etc/nsswitch.conf

# Enable automatically adding remote printers
if ! grep -q '^CreateRemotePrinters Yes' /etc/cups/cups-browsed.conf 2>/dev/null; then
  echo 'CreateRemotePrinters Yes' | sudo tee -a /etc/cups/cups-browsed.conf >/dev/null
fi
