#!/usr/bin/env python3
"""
subnet-calculator.py
Quick subnet calculator for any IP/CIDR
"""

def calculate_subnet(ip, cidr):
    """Calculate network, broadcast, and usable range"""
    
    # Convert IP to integer
    octets = [int(x) for x in ip.split('.')]
    ip_int = (octets[0] << 24) + (octets[1] << 16) + (octets[2] << 8) + octets[3]
    
    # Calculate subnet mask
    mask_int = (0xFFFFFFFF << (32 - cidr)) & 0xFFFFFFFF
    
    # Calculate network address
    network_int = ip_int & mask_int
    
    # Calculate broadcast address
    wildcard = 0xFFFFFFFF ^ mask_int
    broadcast_int = network_int | wildcard
    
    # Calculate usable range
    first_usable = network_int + 1
    last_usable = broadcast_int - 1
    
    # Convert back to dotted decimal
    def int_to_ip(num):
        return f"{(num >> 24) & 0xFF}.{(num >> 16) & 0xFF}.{(num >> 8) & 0xFF}.{num & 0xFF}"
    
    # Calculate number of hosts
    num_hosts = (2 ** (32 - cidr)) - 2
    
    return {
        'ip': ip,
        'cidr': cidr,
        'mask': int_to_ip(mask_int),
        'network': int_to_ip(network_int),
        'broadcast': int_to_ip(broadcast_int),
        'first_usable': int_to_ip(first_usable),
        'last_usable': int_to_ip(last_usable),
        'num_hosts': num_hosts
    }

if __name__ == "__main__":
    import sys
    
    if len(sys.argv) != 2:
        print("Usage: ./subnet-calculator.py IP/CIDR")
        print("Example: ./subnet-calculator.py 192.168.1.100/26")
        sys.exit(1)
    
    ip_cidr = sys.argv[1].split('/')
    ip = ip_cidr[0]
    cidr = int(ip_cidr[1])
    
    result = calculate_subnet(ip, cidr)
    
    print(f"\nSubnet Calculation for {result['ip']}/{result['cidr']}")
    print("=" * 50)
    print(f"IP Address:       {result['ip']}")
    print(f"Subnet Mask:      {result['mask']}")
    print(f"Network Address:  {result['network']}")
    print(f"Broadcast:        {result['broadcast']}")
    print(f"Usable Range:     {result['first_usable']} - {result['last_usable']}")
    print(f"Usable Hosts:     {result['num_hosts']}")
    print()