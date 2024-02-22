#!/bin/bash

# Backup the current sshd_config file
cp /etc/ssh/sshd_config /etc/ssh/sshd_config.backup

# Remove weak key exchanges
sed -i '/^KexAlgorithms/d' /etc/ssh/sshd_config

# Remove weak ciphers
sed -i '/^Ciphers/d' /etc/ssh/sshd_config

awk '/^PubkeyAuthentication/ && !done {print; print ""; print "KexAlgorithms curve25519-sha256@libssh.org,diffie-hellman-group-exchange-sha256"; print "Ciphers chacha20-poly1305@openssh.com,aes256-gcm@openssh.com,aes128-gcm@openssh.com"; print ""; done=1; next}1' /etc/ssh/sshd_config >/tmp/sshd_config_mod && mv /tmp/sshd_config_mod /etc/ssh/sshd_config

# Restart SSH service to apply changes
systemctl restart sshd