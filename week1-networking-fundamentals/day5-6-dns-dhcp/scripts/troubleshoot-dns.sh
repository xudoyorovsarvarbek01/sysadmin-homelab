# Simple query
nslookup google.com
# Returns: IP address and DNS server used

# Query specific DNS server
nslookup google.com 1.1.1.1
# Ask Cloudflare DNS specifically

# Query specific record type
nslookup -type=MX gmail.com
# Returns: Mail servers for Gmail

nslookup -type=TXT google.com
# Returns: SPF, verification records

# Reverse lookup
nslookup 8.8.8.8
# Returns: dns.google


### **dig (Advanced)**

# Basic query
dig google.com

# Short answer only
dig google.com +short
# Returns: Just the IP

# Trace full resolution path
dig google.com +trace
# Shows: Root → TLD → Authoritative

# Query specific record
dig google.com A
dig google.com AAAA
dig google.com MX
dig google.com TXT

# Query specific DNS server
dig @8.8.8.8 google.com
dig @1.1.1.1 google.com

# Reverse lookup
dig -x 8.8.8.8


### **host (Simplest)**

# Quick lookup
host google.com
# Returns: IP address

# Reverse lookup
host 8.8.8.8
# Returns: dns.google

# All records
host -a google.com
