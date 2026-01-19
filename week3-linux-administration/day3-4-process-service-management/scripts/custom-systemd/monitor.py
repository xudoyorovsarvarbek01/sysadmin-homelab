#!/usr/bin/env python3
import time
import datetime

def monitor():
    while True:
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        with open('/var/log/backup-monitor.log', 'a') as f:
            f.write(f"{timestamp} - Backup monitor running\n")
        time.sleep(60)

if __name__ == "__main__":
    monitor()