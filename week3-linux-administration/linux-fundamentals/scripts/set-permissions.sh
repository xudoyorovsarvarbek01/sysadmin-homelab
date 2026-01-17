#!/bin/bash
# set-permissions.sh
# Sets up directory structure with appropriate permissions

set -e

echo "Setting Up Directory Structure"

# Create directories
sudo mkdir -p /opt/admin-scripts
sudo mkdir -p /var/www/myapp
sudo mkdir -p /opt/dev-projects
sudo mkdir -p /opt/services/data
sudo mkdir -p /var/log/app-logs

# Scenario 1: Admin Scripts
echo "Configuring /opt/admin-scripts..."
sudo chown admin-user:sudo /opt/admin-scripts
sudo chmod 750 /opt/admin-scripts

# Create test script
echo '#!/bin/bash' | sudo tee /opt/admin-scripts/test.sh
echo 'echo "Admin script executed"' | sudo tee -a /opt/admin-scripts/test.sh
sudo chmod 750 /opt/admin-scripts/test.sh

# Scenario 2: Developer Workspace (with SGID)
echo "Configuring /opt/dev-projects..."
sudo chown root:developers /opt/dev-projects
sudo chmod 2770 /opt/dev-projects  # 2 = SGID bit

# Create test project
sudo mkdir -p /opt/dev-projects/test-project
echo "# Test Project" | sudo tee /opt/dev-projects/test-project/README.md
sudo chown -R root:developers /opt/dev-projects/test-project

# Scenario 3: Read-only Logs
echo "Configuring /var/log/app-logs..."
sudo chown root:readonly /var/log/app-logs
sudo chmod 750 /var/log/app-logs

# Create test log
echo "$(date): Application started" | sudo tee /var/log/app-logs/app.log
sudo chown root:readonly /var/log/app-logs/app.log
sudo chmod 640 /var/log/app-logs/app.log

echo "=== Permission Setup Complete ==="