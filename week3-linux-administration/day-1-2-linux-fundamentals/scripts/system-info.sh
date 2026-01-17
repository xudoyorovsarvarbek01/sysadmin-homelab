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
grep -E "admin-user|developer|webapp|service-account|readonly-user" /etc/passwd | \
    awk -F: '{printf "%-20s UID: %-6s Home: %s\n", $1, $3, $6}'
echo ""

echo "Groups"
echo "Created groups:"
grep -E "developers|webapp|services|readonly" /etc/group | \
    awk -F: '{printf "%-20s GID: %s\n", $1, $3}'
echo ""

echo "Permission Verification"
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

echo "User Group Memberships"
for user in admin-user developer webapp service-account readonly-user; do
    echo "$user: $(groups $user 2>/dev/null || echo 'user not found')"
done