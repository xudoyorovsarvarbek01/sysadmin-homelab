# Linux Fundamentals - User & Permission Management

## 📋 Overview

Demonstrated core Linux system administration skills including file system navigation, user/group management, and permission configuration on Ubuntu Server.

**Skills Demonstrated:**
- Linux file system hierarchy understanding
- User and group management (useradd, usermod, groupadd)
- File permission management (chmod, chown, umask)
- Understanding /etc/passwd and /etc/shadow
- Command-line proficiency
- Bash scripting for automation

**System:** Ubuntu Server 22.04 LTS  
**Date:** January 2025

---

## 🗂️ Linux File System Hierarchy

### **Key Directories:**
```
/
├── /bin        → Essential user binaries (ls, cp, mv, bash)
├── /boot       → Boot loader files, kernel
├── /dev        → Device files (hard drives, USB, terminals)
├── /etc        → System configuration files
├── /home       → User home directories
├── /lib        → Shared libraries (similar to Windows DLLs)
├── /media      → Removable media mount points (USB, CD)
├── /mnt        → Temporary mount points
├── /opt        → Optional software packages
├── /proc       → Virtual filesystem (process info, system info)
├── /root       → Root user's home directory
├── /run        → Runtime data (PIDs, sockets)
├── /sbin       → System binaries (admin commands: reboot, fdisk)
├── /srv        → Service data (web servers, FTP)
├── /sys        → Virtual filesystem (kernel/hardware info)
├── /tmp        → Temporary files (cleared on reboot)
├── /usr        → User programs and data
│   ├── /usr/bin      → User commands
│   ├── /usr/lib      → Libraries for /usr/bin
│   ├── /usr/local    → Locally installed software
│   └── /usr/share    → Shared data (docs, icons)
└── /var        → Variable data (logs, databases, websites)
    ├── /var/log      → Log files
    ├── /var/www      → Web server files
    └── /var/spool    → Print queues, mail queues
```

### **Important Configuration Files:**
```bash
/etc/passwd       # User account information
/etc/shadow       # Encrypted passwords
/etc/group        # Group information
/etc/sudoers      # Sudo permissions
/etc/hostname     # System hostname
/etc/hosts        # Local DNS/host mappings
/etc/fstab        # Filesystem mount points
/etc/ssh/sshd_config  # SSH server configuration
```

**Verified with:**
```bash
ls -l / | grep "^d"
du -sh /var/log /home /etc
df -h
```

---

## 👥 User & Group Management

### **User Types Created:**

| Username | UID | Primary Group | Secondary Groups | Home Dir | Shell | Purpose |
|----------|-----|---------------|------------------|----------|-------|---------|
| **admin-user** | 1001 | admin-user | sudo, adm | /home/admin-user | /bin/bash | System administrator |
| **developer** | 1002 | developers | docker, www-data | /home/developer | /bin/bash | Application developer |
| **webapp** | 1003 | webapp | www-data | /home/webapp | /bin/bash | Web application user |
| **service-account** | 1004 | services | - | /opt/services | /usr/sbin/nologin | Service account (no login) |
| **readonly-user** | 1005 | readonly | - | /home/readonly-user | /bin/bash | Read-only monitoring user |

### **Groups Created:**
```bash
developers    # GID: 2001 - Development team
webapp        # GID: 2002 - Web application group
services      # GID: 2003 - Service accounts
readonly      # GID: 2004 - Read-only users
```

---

## 🔐 File Permissions Demonstrated

### **Permission Levels:**

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

**Scenario 3: Shared Developer Workspace**
```bash
Directory: /opt/dev-projects/
Owner: root:developers
Permissions: 770 (rwxrwx---)
SGID bit set (2770)

Reasoning:
- Group (developers): Full collaboration
- SGID ensures new files inherit group
- Others: No access

Result: Team can collaborate, files stay in group
```

**Scenario 4: Service Account Data**
```bash
Directory: /opt/services/data/
Owner: service-account:services
Permissions: 700 (rwx------)

Reasoning:
- Only service account can access
- Maximum isolation

Result: Service data completely isolated
```

**Scenario 5: Read-Only Logs**
```bash
Directory: /var/log/app-logs/
Owner: root:readonly
Permissions: 750 (rwxr-x---)
Files: 640 (rw-r-----)

Reasoning:
- Root can write logs
- Readonly group can read
- Others: No access

Result: Monitoring without modification ability
```

---

## 🛠️ Implementation Scripts

### **Script 1: create-users.sh**
```bash
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
grep -E "admin-user|developer|webapp|service-account|readonly-user" /etc/passwd

echo ""
echo "Group memberships:"
for user in admin-user developer webapp service-account readonly-user; do
    echo "$user: $(groups $user)"
done
```

---

### **Script 2: set-permissions.sh**
```bash
#!/bin/bash
# set-permissions.sh
# Sets up directory structure with appropriate permissions

set -e

echo "=== Setting Up Directory Structure ==="

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

# Scenario 2: Web Application
echo "Configuring /var/www/myapp..."
sudo chown -R webapp:www-data /var/www/myapp
sudo find /var/www/myapp -type d -exec chmod 755 {} \;
sudo find /var/www/myapp -type f -exec chmod 644 {} \;

# Create test files
echo "<h1>Test Web App</h1>" | sudo tee /var/www/myapp/index.html
sudo chown webapp:www-data /var/www/myapp/index.html

# Scenario 3: Developer Workspace (with SGID)
echo "Configuring /opt/dev-projects..."
sudo chown root:developers /opt/dev-projects
sudo chmod 2770 /opt/dev-projects  # 2 = SGID bit

# Create test project
sudo mkdir -p /opt/dev-projects/test-project
echo "# Test Project" | sudo tee /opt/dev-projects/test-project/README.md
sudo chown -R root:developers /opt/dev-projects/test-project

# Scenario 4: Service Data
echo "Configuring /opt/services/data..."
sudo chown -R service-account:services /opt/services/data
sudo chmod 700 /opt/services/data

# Create test data
echo "Service data" | sudo -u service-account tee /opt/services/data/config.txt
sudo chmod 600 /opt/services/data/config.txt

# Scenario 5: Read-only Logs
echo "Configuring /var/log/app-logs..."
sudo chown root:readonly /var/log/app-logs
sudo chmod 750 /var/log/app-logs

# Create test log
echo "$(date): Application started" | sudo tee /var/log/app-logs/app.log
sudo chown root:readonly /var/log/app-logs/app.log
sudo chmod 640 /var/log/app-logs/app.log

echo ""
echo "=== Permission Setup Complete ==="
echo ""

# Display results
echo "Directory permissions:"
ls -ld /opt/admin-scripts /var/www/myapp /opt/dev-projects /opt/services/data /var/log/app-logs
```

---

### **Script 3: system-info.sh**
```bash
#!/bin/bash
# system-info.sh
# Displays system information and verifies setup

echo "=== System Information ==="
echo ""

echo "Hostname: $(hostname)"
echo "OS: $(cat /etc/os-release | grep PRETTY_NAME | cut -d'"' -f2)"
echo "Kernel: $(uname -r)"
echo "Uptime: $(uptime -p)"
echo ""

echo "=== Disk Usage ==="
df -h | grep -E "Filesystem|/dev/sd"
echo ""

echo "=== Memory Usage ==="
free -h
echo ""

echo "=== User Accounts ==="
echo "Total users: $(wc -l < /etc/passwd)"
echo ""
echo "Created users:"
grep -E "admin-user|developer|webapp|service-account|readonly-user" /etc/passwd | \
    awk -F: '{printf "%-20s UID: %-6s Home: %s\n", $1, $3, $6}'
echo ""

echo "=== Groups ==="
echo "Created groups:"
grep -E "developers|webapp|services|readonly" /etc/group | \
    awk -F: '{printf "%-20s GID: %s\n", $1, $3}'
echo ""

echo "=== Permission Verification ==="
echo ""
echo "Admin Scripts:"
ls -ld /opt/admin-scripts
ls -l /opt/admin-scripts/test.sh 2>/dev/null || echo "  (no files yet)"
echo ""

echo "Web Application:"
ls -ld /var/www/myapp
ls -l /var/www/myapp/index.html 2>/dev/null || echo "  (no files yet)"
echo ""

echo "Developer Projects:"
ls -ld /opt/dev-projects
echo ""

echo "Service Data:"
ls -ld /opt/services/data
echo ""

echo "Application Logs:"
ls -ld /var/log/app-logs
ls -l /var/log/app-logs/*.log 2>/dev/null || echo "  (no logs yet)"
echo ""

echo "=== User Group Memberships ==="
for user in admin-user developer webapp service-account readonly-user; do
    echo "$user: $(groups $user 2>/dev/null || echo 'user not found')"
done
```

---

## 🧪 Testing & Verification

### **Test 1: User Creation Verification**
```bash
# Verify users exist
cat /etc/passwd | grep -E "admin-user|developer|webapp|service-account|readonly-user"

# Expected output:
admin-user:x:1001:1001:System Administrator:/home/admin-user:/bin/bash
developer:x:1002:1002:Application Developer:/home/developer:/bin/bash
webapp:x:1003:1003:Web Application User:/home/webapp:/bin/bash
service-account:x:999:999:Service Account:/opt/services:/usr/sbin/nologin
readonly-user:x:1005:1005:Read-Only Monitoring User:/home/readonly-user:/bin/bash
```

### **Test 2: Password File Security**
```bash
# Check /etc/shadow permissions (should be 640 or 000)
ls -l /etc/shadow

# Expected: -rw-r----- 1 root shadow

# Verify passwords are encrypted
sudo cat /etc/shadow | grep admin-user

# Expected: admin-user:$6$randomhash...:19000:0:99999:7:::
```

### **Test 3: Group Membership**
```bash
# Check admin-user has sudo access
groups admin-user
# Expected: admin-user : admin-user sudo adm

# Check developer groups
groups developer
# Expected: developer : developer developers docker www-data
```

### **Test 4: Permission Effectiveness**
```bash
# Test 1: Admin can access scripts, others cannot
sudo -u admin-user ls /opt/admin-scripts  # ✓ Success
sudo -u readonly-user ls /opt/admin-scripts  # ✗ Permission denied

# Test 2: Developer can write to dev-projects
sudo -u developer touch /opt/dev-projects/test.txt  # ✓ Success
ls -l /opt/dev-projects/test.txt
# File should belong to developers group (SGID effect)

# Test 3: Service account cannot login
su - service-account
# Expected: "This account is currently not available"

# Test 4: Readonly can read logs but not write
sudo -u readonly-user cat /var/log/app-logs/app.log  # ✓ Success
sudo -u readonly-user echo "test" >> /var/log/app-logs/app.log  # ✗ Permission denied

# Test 5: Webapp can modify web files
sudo -u webapp echo "Updated" >> /var/www/myapp/index.html  # ✓ Success
```

### **Test 5: Special Permissions (SGID)**
```bash
# Verify SGID on /opt/dev-projects
ls -ld /opt/dev-projects
# Expected: drwxrws--- ... (note the 's' in group execute position)

# Create file as developer, verify group ownership
sudo -u developer touch /opt/dev-projects/newfile.txt
ls -l /opt/dev-projects/newfile.txt
# Expected: ... developer developers ... (inherits developers group)
```

---

## 📚 Key Concepts Demonstrated

### **/etc/passwd Structure:**
```
username:x:UID:GID:comment:home_directory:shell

Example:
admin-user:x:1001:1001:System Administrator:/home/admin-user:/bin/bash

Fields:
1. Username: admin-user
2. Password placeholder: x (actual password in /etc/shadow)
3. UID: 1001 (user ID)
4. GID: 1001 (primary group ID)
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

## 📸 Screenshots

### **Required Screenshots:**

1. **File System Hierarchy** (`ls -l /`)
2. **User Creation** (output of create-users.sh)
3. **Permissions Demo** (`ls -l` on all 5 scenarios)
4. **`/etc/passwd` and `/etc/shadow`** (showing created users, redact passwords)
5. **Permission Levels** (test results showing access/denied)

---

## 🎯 Deliverable Summary

**Created:**
- ✅ 5 users with distinct permission levels
- ✅ 4 custom groups
- ✅ 5 directory scenarios with appropriate permissions
- ✅ 3 automation scripts (user creation, permissions, verification)
- ✅ Complete documentation

**Permission Levels:**
1. **Full Admin** - admin-user (sudo access)
2. **Developer** - developer (group collaboration, docker access)
3. **Application User** - webapp (web server files)
4. **Service Account** - service-account (no login, isolated)
5. **Read-Only** - readonly-user (monitoring, no write)

**Skills Validated:**
- File system navigation and understanding
- User/group management (useradd, usermod, groupadd)
- Permission management (chmod, chown)
- Special permissions (SGID, proper umask)
- Security best practices (/etc/shadow protection)
- Bash scripting automation

---

## 🔗 Related Projects

- [Week 2: Active Directory](../../week2-windows-server/active-directory-setup/)
- Day 3-4: Linux Process & Service Management *(coming next)*

---

## 📝 Commands Reference

**User Management:**
```bash
sudo useradd -m -s /bin/bash username    # Create user with home dir
sudo passwd username                      # Set password
sudo usermod -aG groupname username      # Add to group
sudo userdel -r username                 # Delete user and home
```

**Group Management:**
```bash
sudo groupadd groupname                  # Create group
sudo groupdel groupname                  # Delete group
groups username                          # Show user's groups
```

**Permissions:**
```bash
chmod 755 file                           # Numeric mode
chmod u+x,g+r,o-w file                  # Symbolic mode
chown user:group file                    # Change owner
chown -R user:group directory           # Recursive
```

**Viewing:**
```bash
ls -l                                    # Long listing
ls -la                                   # Include hidden
cat /etc/passwd                          # View users
cat /etc/group                           # View groups
id username                              # User info
```

---

*Project completed as part of 10-week sysadmin training program*  
*Date: January 2025*