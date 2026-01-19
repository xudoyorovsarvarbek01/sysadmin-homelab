# Linux Fundamentals - User & Permission Management

## Overview

Demonstrated core Linux system administration skills including file system navigation, user/group management, and permission configuration on Ubuntu Server.

**Skills Demonstrated:**
- Linux file system hierarchy understanding
- User and group management (useradd, usermod, groupadd)
- File permission management (chmod, chown, umask)
- Understanding /etc/passwd and /etc/shadow
- Command-line proficiency
- Bash scripting for automation

**System:** Ubuntu Server 22.04 LTS  
**Date:** January 2026

---

## User & Group Management

### **User Types Created:**

| Username | UID | Primary Group | Secondary Groups | Home Dir | Shell | Purpose |
|----------|-----|---------------|------------------|----------|-------|---------|
| **admin-user** | 1002 | admin-user | sudo, adm | /home/admin-user | /bin/bash | System administrator |
| **developer** | 1003 | developers | docker, www-data | /home/developer | /bin/bash | Application developer |
| **webapp** | 1004 | webapp | www-data | /home/webapp | /bin/bash | Web application user |
| **service-account** | 1005 | services | - | /opt/services | /usr/sbin/nologin | Service account (no login) |
| **readonly-user** | 1006 | readonly | - | /home/readonly-user | /bin/bash | Read-only monitoring user |

---

## File Permissions Demonstrated

### **Permission Bits:**
```
-rwxrwxrwx
│││││││││└─ Others execute
││││││││└── Others write
│││││││└─── Others read
││││││└──── Group execute
│││││└───── Group write
││││└────── Group read
│││└─────── Owner execute
││└──────── Owner write
│└───────── Owner read
└────────── File type (- = file, d = directory, l = link)
```

**Numeric (Octal) Format:**
```
7 = rwx (read, write, execute)
6 = rw- (read, write)
5 = r-x (read, execute)
4 = r-- (read only)
3 = -wx (write, execute)
2 = -w- (write only)
1 = --x (execute only)
0 = --- (no permissions)
```

**Symbolic Format:**
```
u = user (owner)
g = group
o = others
a = all

+ = add permission
- = remove permission
= = set exact permission
```

### **Permission Scenarios Implemented:**

**Scenario 1: Admin Scripts Folder**
```bash
Directory: /opt/admin-scripts/
Owner: admin-user:sudo
Permissions: 750 (rwxr-x---)

Reasoning:
- Owner (admin-user): Full control (rwx)
- Group (sudo): Read and execute (r-x)
- Others: No access (---)

Result: Only admin and sudo group can access scripts
```

**Scenario 2: Web Application Files**
```bash
Directory: /var/www/myapp/
Owner: webapp:www-data
Permissions: 755 (rwxr-xr-x) on directories
             644 (rw-r--r--) on files

Reasoning:
- Owner: Full control on dirs, read/write on files
- Group/Others: Read and traverse only

Result: Web server can read, owner can modify
```

---

## Implementation Scripts

### **Script 1: create-users.sh**
```bash
#!/bin/bash
# create-users.sh
# Creates 5 users with different permission levels

# Exit on error
set -e

echo "Creating Users and Groups"

# Create groups
echo "Creating groups..."
sudo groupadd -f developers
sudo groupadd -f webapp
sudo groupadd -f services
sudo groupadd -f readonly

# User 1: Admin User (sudo access)
echo "Creating admin-user..."
sudo useradd -m -s /bin/bash -c "System Administrator" admin-user
.........
```
*Full [create-users.sh](./scripts/create-users.sh)* script
---

### **Script 2: set-permissions.sh**
```bash
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
.........
```
*Full [set-permissions.sh](./scripts/set-permissions.sh)* script
---

### **Script 3: system-info.sh**
```bash
#!/bin/bash
# system-info.sh
# Displays system information and verifies setup

echo "System Information"
echo ""

echo "Hostname: $(hostname)"
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo ""

echo "Disk Usage"
df -h | grep -E "Filesystem|/dev/sd"
echo ""

echo "Memory Usage"
free -h
echo ""

echo "User Accounts"
echo "Total users: $(wc -l < /etc/passwd)"
echo ""
echo "Created users:"
......
```
*Full [system-info.sh](./scripts/system-info.sh)* script
---

## Testing & Verification

### **Test 1: User Creation Verification**
```bash
# Verify users exist
cat /etc/passwd | grep -E "admin-user|developer|webapp|service-account|readonly-user"

# Expected output:
admin-user:x:1002:1002:System Administrator:/home/admin-user:/bin/bash
developer:x:1003:1003:Application Developer:/home/developer:/bin/bash
webapp:x:1004:1004:Web Application User:/home/webapp:/bin/bash
service-account:x:999:999:Service Account:/opt/services:/usr/sbin/nologin
readonly-user:x:1005:1005:Read-Only Monitoring User:/home/readonly-user:/bin/bash
```

### **Test 2: Group Membership**
```bash
# Check admin-user has sudo access
groups admin-user
# Expected: admin-user : admin-user sudo adm

# Check developer groups
groups developer
# Expected: developer : developer developers docker www-data
```

---

## Key Concepts Demonstrated

### **/etc/passwd Structure:**
```
username:x:UID:GID:comment:home_directory:shell

Example:
admin-user:x:1002:1002:System Administrator:/home/admin-user:/bin/bash

Fields:
1. Username: admin-user
2. Password placeholder: x (actual password in /etc/shadow)
3. UID: 1002 (user ID)
4. GID: 1002 (primary group ID)
5. Comment: System Administrator
6. Home directory: /home/admin-user
7. Shell: /bin/bash
```

### **/etc/shadow Structure:**
```
username:encrypted_password:last_change:min:max:warn:inactive:expire

Security:
- Only root can read
- Contains actual password hashes
- Password aging information
```


### **Special Permission Bits:**
```
SUID (4): Executes as file owner
- chmod 4755 file
- Example: /usr/bin/passwd (runs as root)

SGID (2): New files inherit directory group
- chmod 2770 directory
- Used in /opt/dev-projects for team collaboration

Sticky Bit (1): Only owner can delete files
- chmod 1777 directory
- Example: /tmp (everyone can write, only owner can delete their files)
```

---

## Deliverable Summary

**Created:**
- ✅ 5 users with distinct permission levels
- ✅ 4 custom groups
- ✅ 5 directory scenarios with appropriate permissions
- ✅ 3 automation scripts (user creation, permissions, verification)
- ✅ Complete documentation

**Skills Validated:**
- File system navigation and understanding
- User/group management (useradd, usermod, groupadd)
- Permission management (chmod, chown)
- Special permissions (SGID, proper umask)
- Security best practices (/etc/shadow protection)
- Bash scripting automation

---

## Related Projects

- [Week 2: Active Directory](../../week2-windows-server/active-directory-setup/)
- [Day 3-4: Linux Process & Service Management](../day-3-4-Process-&-Service-Management/)

---

*Project completed as part of 10-week sysadmin training program*  
*Date: Mid January 2026*