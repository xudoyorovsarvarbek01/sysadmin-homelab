#!/bin/bash
# create-users.sh
# Creates 5 users with different permission levels

# Exit on error
set -e

echo "=== Creating Users and Groups ==="

# Create groups
echo "Creating groups..."
sudo groupadd -f developers
sudo groupadd -f webapp
sudo groupadd -f services
sudo groupadd -f readonly

# User 1: Admin User (sudo access)
echo "Creating admin-user..."
sudo useradd -m -s /bin/bash -c "System Administrator" admin-user
echo "admin-user:SecureP@ss123" | sudo chpasswd
sudo usermod -aG sudo,adm admin-user

# User 2: Developer (development access)
echo "Creating developer..."
sudo useradd -m -s /bin/bash -c "Application Developer" developer
echo "developer:DevP@ss123" | sudo chpasswd
sudo usermod -aG developers,docker,www-data developer

# User 3: Web Application User
echo "Creating webapp..."
sudo useradd -m -s /bin/bash -c "Web Application User" webapp
echo "webapp:WebP@ss123" | sudo chpasswd
sudo usermod -aG www-data webapp

# User 4: Service Account (no login shell)
echo "Creating service-account..."
sudo useradd -r -s /usr/sbin/nologin -d /opt/services -c "Service Account" service-account
# No password needed (can't login)
sudo usermod -aG services service-account

# User 5: Read-only User
echo "Creating readonly-user..."
sudo useradd -m -s /bin/bash -c "Read-Only Monitoring User" readonly-user
echo "readonly-user:ReadP@ss123" | sudo chpasswd
sudo usermod -aG readonly readonly-user

echo ""
echo "=== User Creation Complete ==="
echo ""

# Display created users
echo "Created users:"
cat /etc/passwd grep "admin-user|developer|webapp|service-account|readonly-user" 

echo ""
echo "Group memberships:"
for user in admin-user developer webapp service-account readonly-user; do
    echo "$user: $(groups $user)"
done