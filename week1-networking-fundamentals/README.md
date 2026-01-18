# Week 1: Networking Fundamentals

## Overview

Comprehensive deep dive into networking fundamentals essential for system administration. Covered OSI model, TCP/IP stack, subnetting, DNS, and DHCP with hands-on packet analysis and practical configuration.

**Duration:** 7 days  
**Tools Used:** Wireshark, VirtualBox, dnsmasq/BIND9, nslookup
**Completion Date:** January 2026

---

## Learning Objectives Achieved

✅ **OSI Model & TCP/IP Protocol Suite**
- Understand all 7 OSI layers and their functions
- Difference between TCP and UDP protocols
- Analyze three-way handshake with packet captures
- Master Wireshark for packet analysis

✅ **IP Addressing & Subnetting**
- Convert between binary and decimal instantly
- Subnet any IP address in under 30 seconds
- Design VLSM networks for real-world scenarios
- Calculate network/broadcast addresses mentally

✅ **DNS & DHCP Services**
- Understand DNS hierarchy (root, TLD, authoritative)
- Configure local DNS server (dnsmasq/BIND9)
- Analyze DHCP DORA process with packet captures
- Troubleshoot DNS issues using nslookup

---

## 📚 Module Breakdown

### **Day 1-2: OSI Model & TCP/IP**

**Key Concepts:**
- OSI 7-layer model (Physical → Application)
- TCP three-way handshake (SYN, SYN-ACK, ACK)
- TCP vs UDP (reliability vs speed)
- Wireshark packet analysis fundamentals

**Practical Work:**
- Captured and analyzed TCP handshakes
- Compared TCP vs UDP traffic (HTTP vs DNS)
- Identified all 7 OSI layers in real packets
- Created packet capture library

**Skills Demonstrated:**
- Network protocol analysis
- Troubleshooting methodology
- Critical thinking (why TCP for web, UDP for DNS?)

[📂 View Day 1-2 Details →](./day1-2-osi-tcp/)

---

### **Day 3-4: IP Addressing & Subnetting**

**Key Concepts:**
- IPv4 structure and classes (A, B, C)
- Subnet masks and CIDR notation
- Network/broadcast address calculation
- VLSM (Variable Length Subnet Masking)
- Subnetting strategy and design

**Practical Work:**
- Solved 50+ subnetting problems
- Designed multi-subnet networks
- Created subnet calculator script
- Achieved <30 second subnetting speed

**Skills Demonstrated:**
- Binary/decimal conversion
- Network design and planning
- Mathematical problem-solving
- Automation with Python

[📂 View Day 3-4 Details →](./day3-4-subnetting/)

---

### **Day 5-6: DNS & DHCP**

**Key Concepts:**
- DNS hierarchy (root → TLD → authoritative)
- DNS record types (A, AAAA, CNAME, MX, TXT, PTR, NS)
- DNS resolution (recursive vs iterative)
- DHCP DORA process (Discover, Offer, Request, Acknowledge)
- DNS troubleshooting (nslookup, dig, host)

**Practical Work:**
- Set up local DNS server (dnsmasq)
- Configured custom DNS records
- Captured DHCP DORA in Wireshark
- Troubleshot DNS resolution issues
- Analyzed DNS queries at packet level

**Skills Demonstrated:**
- Service configuration (DNS server setup)
- Protocol analysis (DHCP packets)
- Command-line tools mastery
- Critical infrastructure understanding

[📂 View Day 5-6 Details →](./day5-6-dns-dhcp/)

---

## 🛠️ Tools & Technologies

**Packet Analysis:**
- Wireshark (packet capture and analysis)
- tcpdump (command-line packet capture)

**DNS Tools:**
- nslookup (basic DNS queries)
- dig (advanced DNS queries)
- host (simple DNS lookups)
- dnsmasq (lightweight DNS/DHCP server)
- BIND9 (professional DNS server)

**Network Tools:**
- ping (ICMP connectivity testing)
- traceroute/tracert (route tracing)
- netstat (network statistics)
- ip/ifconfig (network interface configuration)

**Scripting:**
- Python (subnet calculator)
- Bash (DNS testing automation)

---

## 📊 Key Achievements

**Networking Knowledge:**
```
✓ Can explain OSI model to technical and non-technical audiences
✓ Understands when to use TCP vs UDP (and why)
✓ Subnet any IP address in under 30 seconds
✓ Design subnet schemes for organizations
✓ Configure and troubleshoot DNS servers
✓ Analyze network traffic with Wireshark
✓ Troubleshoot common network issues systematically
```

**Practical Skills:**
```
✓ 20+ hours of hands-on Wireshark analysis
✓ 50+ subnetting problems solved
✓ DNS server configured from scratch
✓ DHCP process analyzed at packet level
✓ Network troubleshooting methodology mastered
```

**Deliverables:**
```
✓ Packet capture library (TCP, UDP, DNS, DHCP)
✓ Subnet calculator script
✓ DNS server configuration files
✓ Comprehensive documentation
✓ Troubleshooting playbooks
```

---

## Related Projects

- [Week 2: Windows Server Administration](../week2-windows-server/)
- [Week 3: Linux System Administration](../week3-linux-administration/)

---

##   Resources Used

**Video Courses:**
- Professor Messer Network+ Series
- NetworkChuck
- David Bombal
- Chris Greer

**Practice Sites/sources:**
- SubnettingPractice.com (500+ problems completed)
- Chris Greer Wireshark Sample Captures

---

*Week 1 completed as part of 10-week intensive sysadmin training program*  
*Focus: Network fundamentals mastery for enterprise system administration*

*Start of January 2026*

