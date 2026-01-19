### **ps (Process Status):**
```bash
# All processes
ps aux

# Specific user processes
ps -u username

# Process tree
ps auxf

# Find specific process
ps aux | grep ssh

# Custom columns
ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
```

### **top (Interactive):**
```bash
# Launch top
top

# Shortcuts:
# M - sort by memory
# P - sort by CPU
# k - kill process
# q - quit

# One-time snapshot
top -b -n 1
```

### **htop (Better top):**
```bash
# Install if needed
sudo apt install htop

# Launch
htop

# Features:
# - Color-coded
# - Mouse support
# - Tree view (F5)
# - Search (F3)
# - Kill process (F9)
```

### **kill Commands:**
```bash
# Graceful shutdown (SIGTERM)
kill PID

# Force kill (SIGKILL)
kill -9 PID

# Kill by name
killall ssh
pkill ssh

# Kill all processes by user
pkill -u username
```

**Common Signals:**
- `SIGTERM (15)` - Graceful shutdown (default)
- `SIGKILL (9)` - Force kill (can't be caught)
- `SIGHUP (1)` - Reload config
- `SIGSTOP (19)` - Pause process
