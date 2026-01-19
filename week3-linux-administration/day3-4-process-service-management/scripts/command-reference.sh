## Commands Reference

# Service Management
systemctl start|stop|restart|reload service
systemctl enable|disable service
systemctl status service
journalctl -u service

# Process Management
ps aux | grep process
top / htop
kill PID / kill -9 PID
pkill process-name

# Cron Management
crontab -e  # Edit
crontab -l  # List
crontab -r  # Remove

# Service Creation
sudo nano /etc/systemd/system/myservice.service
sudo systemctl daemon-reload
sudo systemctl enable myservice
sudo systemctl start myservice








## Verification Tests

# 1. Custom service running
systemctl is-active backup-monitor
# Expected: active

# 2. Service enabled on boot
systemctl is-enabled backup-monitor
# Expected: enabled

# 3. Service logs working
journalctl -u backup-monitor --since "5 minutes ago"
# Should show recent log entries

# 4. Cron job scheduled
sudo crontab -l | grep weekly-backup
# Should show cron entry

# 5. Process monitoring
ps aux | grep monitor.py
# Should show Python process running