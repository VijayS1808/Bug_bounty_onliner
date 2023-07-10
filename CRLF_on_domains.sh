#!/bin/bash

YELLOW='\033[0;33m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${YELLOW}CRLF Injection Vulnerability Check${NC}"
echo -e "${YELLOW}===============================${NC}"
echo -e "This script checks for potential CRLF Injection vulnerabilities in the given URLs."
echo -e "It appends various URL-encoded sequences with 'crlf:crlf' to the URLs and checks if the response contains 'crlf:crlf'."
echo -e "If a match is found, it indicates a possible CRLF Injection vulnerability.\n"

while read -r line; do
    if curl -Iks -m 10 "$line/%0D%0Acrlf:crlf" | grep -q "^crlf:crlf" ||
       curl -Iks -m 10 "$line/%0d%0acrlf:crlf" | grep -q "^crlf:crlf" ||
       curl -Iks -m 10 "$line/%E5%98%8D%E5%98%8Acrlf:crlf" | grep -q "^crlf:crlf"; then
        echo -e "${GREEN}The URL $line may be vulnerable to CRLF Injection. Check Manually${NC}"
    fi
done < sub.txt
