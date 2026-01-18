#!/usr/bin/env python3

import ipaddress
import math

class Colors:
    HEADER = '\033[95m'
    BLUE = '\033[94m'
    GREEN = '\033[92m'
    YELLOW = '\033[93m'
    RED = '\033[91m'
    END = '\033[0m'
    BOLD = '\033[1m'

def print_header(text):
    print(f"\n{Colors.BOLD}{Colors.BLUE}{'='*80}{Colors.END}")
    print(f"{Colors.BOLD}{Colors.BLUE}{text.center(80)}{Colors.END}")
    print(f"{Colors.BOLD}{Colors.BLUE}{'='*80}{Colors.END}\n")

def print_section(text):
    print(f"\n{Colors.BOLD}{Colors.GREEN}{text}{Colors.END}")
    print(f"{Colors.GREEN}{'-'*80}{Colors.END}")

def calculate_subnet_mask(hosts):
    """Calculate subnet mask based on required hosts"""
    required_hosts = hosts + 2
    host_bits = math.ceil(math.log2(required_hosts))
    subnet_mask = 32 - host_bits
    return subnet_mask, 2 ** host_bits

def calculate_vlsm(base_network, base_mask, subnets):
    """Calculate VLSM for given subnets"""
    sorted_subnets = sorted(subnets, key=lambda x: x['hosts'], reverse=True)
    
    network = ipaddress.IPv4Network(f"{base_network}/{base_mask}", strict=False)
    current_ip = int(network.network_address)
    
    results = []
    
    for subnet in sorted_subnets:
        subnet_mask, block_size = calculate_subnet_mask(subnet['hosts'])
        
        network_addr = ipaddress.IPv4Address(current_ip)
        subnet_network = ipaddress.IPv4Network(f"{network_addr}/{subnet_mask}", strict=False)
        
        first_usable = subnet_network.network_address + 1
        last_usable = subnet_network.broadcast_address - 1
        usable_hosts = block_size - 2
        
        results.append({
            'name': subnet['name'],
            'required_hosts': subnet['hosts'],
            'network': str(subnet_network.network_address),
            'subnet_mask': f"/{subnet_mask}",
            'first_usable': str(first_usable),
            'last_usable': str(last_usable),
            'broadcast': str(subnet_network.broadcast_address),
            'usable_hosts': usable_hosts,
            'total_ips': block_size
        })
        
        current_ip += block_size
    
    return results

def print_results(base_network, base_mask, results):
    """Print formatted results"""
    print_header("VLSM CALCULATION RESULTS")
    
    print(f"{Colors.BOLD}Base Network: {Colors.END}{base_network}/{base_mask}\n")
    
    for i, result in enumerate(results, 1):
        print(f"{Colors.BOLD}{Colors.YELLOW}Subnet {i}: {result['name']}{Colors.END}")
        print(f"{Colors.YELLOW}{'-'*80}{Colors.END}")
        print(f"  {Colors.BOLD}Network Address:{Colors.END}    {result['network']}{result['subnet_mask']}")
        print(f"  {Colors.BOLD}First Usable IP:{Colors.END}    {result['first_usable']}")
        print(f"  {Colors.BOLD}Last Usable IP:{Colors.END}     {result['last_usable']}")
        print(f"  {Colors.BOLD}Broadcast Address:{Colors.END}  {result['broadcast']}")
        print(f"  {Colors.BOLD}Usable Hosts:{Colors.END}       {result['usable_hosts']} {Colors.GREEN}(required: {result['required_hosts']}){Colors.END}")
        print(f"  {Colors.BOLD}Total IPs:{Colors.END}          {result['total_ips']}")
        print()

def main():
    print_header("VLSM SUBNET CALCULATOR")
    
    # Get base network
    print_section("Base Network Configuration")
    base_network = input(f"{Colors.BOLD}Enter network address (e.g., 192.168.1.0): {Colors.END}").strip()
    base_mask = input(f"{Colors.BOLD}Enter prefix length (e.g., 24): {Colors.END}").strip()
    
    # Get number of subnets
    print_section("Subnet Requirements")
    num_subnets = int(input(f"{Colors.BOLD}How many subnets do you need? {Colors.END}"))
    
    # Get subnet details
    subnets = []
    for i in range(num_subnets):
        print(f"\n{Colors.BOLD}{Colors.BLUE}Subnet {i+1}:{Colors.END}")
        name = input(f"  Name: ").strip()
        hosts = int(input(f"  Required hosts: "))
        subnets.append({'name': name, 'hosts': hosts})
    
    # Calculate VLSM
    results = calculate_vlsm(base_network, base_mask, subnets)
    
    # Print results
    print_results(base_network, base_mask, results)
    
    print(f"{Colors.GREEN}{Colors.BOLD}✓ Calculation complete!{Colors.END}\n")

if __name__ == "__main__":
    try:
        main()
    except KeyboardInterrupt:
        print(f"\n\n{Colors.RED}Calculation cancelled.{Colors.END}\n")
    except Exception as e:
        print(f"\n{Colors.RED}Error: {e}{Colors.END}\n")