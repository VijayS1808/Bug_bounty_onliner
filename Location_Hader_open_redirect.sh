#!/bin/bash

BLUE='\033[0;34m'
PINK='\033[1;35m'
NC='\033[0m' # No Color

while read -r line; do
    if curl -skI "$line" -H "User-Agent: Mozilla/Firefox 80" | grep "HTTP/1.1 \|HTTP/2" | cut -d" " -f2 | grep "301\|302\|307" >/dev/null; then
        domain=$(curl -skI "$line" -H "User-Agent: Mozilla/Firefox 80" | grep -iE "Location:|location:" | cut -d" " -f2 | cut -d"/" -f1-3 | sed "s/^http\(\|s\):\/\///g" | sed "s/\s*$//")
        path=$(echo "$line" | cut -d"/" -f4-20)
        if echo "$path" | grep -q "$domain"; then
            echo -e "${PINK}Reflection Found on Location headers from URL '$line'${NC}"
            curl -skI "$line" -H "User-Agent: Mozilla/Firefox 80" | sed -n '/Location\|location/p'
            echo ""
        fi
    fi
done < urls.txt
