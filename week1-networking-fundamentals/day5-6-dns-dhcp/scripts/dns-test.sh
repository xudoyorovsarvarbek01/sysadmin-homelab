#!/bin/bash
# dns-test.sh
# Test DNS resolution and server response times

echo "=== DNS Resolution Test ==="
echo ""

# List of DNS servers to test
DNS_SERVERS=("8.8.8.8" "1.1.1.1" "9.9.9.9" "8.8.4.4")
DOMAINS=("google.com" "github.com" "cloudflare.com")

for dns in "${DNS_SERVERS[@]}"; do
    echo "Testing DNS server: $dns"
    
    for domain in "${DOMAINS[@]}"; do
        echo -n "  $domain: "
        
        # Time the query
        start=$(date +%s%N)
        result=$(nslookup $domain $dns 2>&1 | grep "Address:" | tail -1 | awk '{print $2}')
        end=$(date +%s%N)
        
        time_ms=$(( (end - start) / 1000000 ))
        
        if [ -n "$result" ]; then
            echo "$result (${time_ms}ms)"
        else
            echo "FAILED"
        fi
    done
    echo ""
done

echo "=== DNS Cache Test ==="
echo ""

# Test cache by querying twice
echo "First query (uncached):"
time dig google.com @8.8.8.8 +noall +answer

echo ""
echo "Second query (should be faster if cached locally):"
time dig google.com @8.8.8.8 +noall +answer