# Create directories and script
sudo mkdir -p /opt/backup-monitor
sudo nano /opt/backup-monitor/monitor.py
# (paste script)
sudo chmod +x /opt/backup-monitor/monitor.py

# Create service file
sudo nano /etc/systemd/system/backup-monitor.service
# (paste service config)

# Reload systemd
sudo systemctl daemon-reload

# Enable and start
sudo systemctl enable backup-monitor
sudo systemctl start backup-monitor

# Check status
systemctl status backup-monitor

# View logs
journalctl -u backup-monitor -f