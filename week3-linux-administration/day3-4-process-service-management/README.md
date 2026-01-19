# Day 3-4: Process & Service Management

## 📋 Overview

Mastered Linux process and service management using systemd, cron, and process monitoring tools. Created custom systemd services and automated tasks.

**Skills:** systemd, systemctl, process management (ps/top/htop), cron jobs, service creation  
**System:** Ubuntu Server 22.04 LTS

---

## ⚙️ systemd vs init

| Feature | **systemd** (Modern) | **init** (Legacy) |
|---------|---------------------|-------------------|
| Startup | Parallel (faster) | Sequential (slower) |
| Config | Unit files (.service) | Shell scripts (/etc/init.d) |
| Management | systemctl | service command |
| Dependencies | Built-in | Manual scripting |
| Logs | journalctl (centralized) | /var/log files |

**systemd is default on:** Ubuntu 16.04+, CentOS 7+, Debian 8+

---

## 🔧 systemctl Commands

### **Basic Service Management:**
```bash
# Start service (this session only)
sudo systemctl start ssh

# Stop service
sudo systemctl stop ssh

# Restart service
sudo systemctl restart ssh

# Reload config (no downtime)
sudo systemctl reload ssh

# Enable (start on boot)
sudo systemctl enable ssh

# Disable (don't start on boot)
sudo systemctl disable ssh

# Check status
sudo systemctl status ssh

# Check if enabled
systemctl is-enabled ssh

# Check if active
systemctl is-active ssh
```

### **Viewing Services:**
```bash
# List all services
systemctl list-units --type=service

# List running services only
systemctl list-units --type=service --state=running

# List failed services
systemctl list-units --type=service --state=failed

# Show service details
systemctl show ssh

# View service logs
journalctl -u ssh
journalctl -u ssh -f  # Follow (tail)
journalctl -u ssh --since today
```

---

## 📊 Process Management

### **ps (Process Status):**
```bash
# All processes
ps aux

# Specific user processes
ps -u username

# Process tree
ps auxf

# Find specific process
.........

Full [process-management](process-management.md)

---

## Cron Jobs

### **Cron Format:**
```
* * * * * username command
│ │ │ │ │
│ │ │ │ └─── Day of week (0-7, Sun=0 or 7)
│ │ │ └───── Month (1-12)
│ │ └─────── Day of month (1-31)
│ └───────── Hour (0-23)
└─────────── Minute (0-59)
```

### **Examples:**
```bash
# Every minute
* * * * * username /path/script.sh

# Every day at 2:30 AM
30 2 * * * username /path/backup.sh

# Every Monday at 9 AM
0 9 * * 1 username /path/weekly-report.sh
```

### **Managing Cron:**
```bash
# Edit crontab for that user
crontab -e

# List crontab
crontab -l

# Remove crontab
crontab -r

# Edit other user's crontab (root only)
sudo crontab -u username -e

# System-wide cron
sudo nano /etc/crontab
```

### **Cron Directories:**
```bash
/etc/cron.daily/    # Scripts run daily
/etc/cron.hourly/   # Scripts run hourly
/etc/cron.weekly/   # Scripts run weekly
/etc/cron.monthly/  # Scripts run monthly

# Add script (make executable)
sudo cp script.sh /etc/cron.daily/
sudo chmod +x /etc/cron.daily/script.sh
```

---

## 🛠️ Practical Exercises

### **Exercise 1: Custom systemd Service**

**File in system:** `/etc/systemd/system/backup-monitor.service`
[backup-monitor.service](./scripts/custom-systemd/backup-monitor.service)

**Service Script:** `/opt/backup-monitor/monitor.py`
[monitor.py](./scripts/custom-systemd/monitor.py)

**Setup:**
[setup.bash](./scripts/custom-systemd/setup.sh)

### **Exercise 2: Automated Backup Script**

**Script:** `/usr/local/bin/weekly-backup.sh`
[weekly-backup.sh](./scripts/automated-backup/weekly-backup.sh)

**Setup Cron:**
```bash
# Make script executable
sudo chmod +x /usr/local/bin/weekly-backup.sh

# Add to crontab (2 AM weekly)
sudo crontab -e
# Add line:
0 2 * * * /usr/local/bin/weekly-backup.sh

# Verify
sudo crontab -l
```

[command-reference](./scripts/command-reference.sh)

---

## Deliverables

✅ **Custom systemd service** (backup-monitor.service)  
✅ **Automated backup** via cron (weekly at 2 AM)  
✅ **Service management** (Apache, SSH)  
✅ **Process monitoring** (ps, top, htop)  
✅ **All services start on boot**

**Files Created:**
- `/etc/systemd/system/backup-monitor.service`
- `/opt/backup-monitor/monitor.py`
- `/usr/local/bin/weekly-backup.sh`
- Crontab entry for backups

---

*Completed as part of Week 3: Linux System Administration*
*Date: Mid January 2026*