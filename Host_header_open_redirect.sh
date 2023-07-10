#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

while read -r line; do
    if curl -Iks -m 10 "$line" -H "CF-Connecting_IP: https://redirect.com" -H "From: root@https://redirect.com" -H "Client-IP: https://redirect.com" -H "X-Client-IP: https://redirect.com" -H "X-Forwarded-For: https://redirect.com" -H "X-Wap-Profile: https://redirect.com" -H "Forwarded: https://redirect.com" -H "True-Client-IP: https://redirect.com" -H "Contact: root@https://redirect.com" -H "X-Originating-IP: https://redirect.com" -H "X-Real-IP: https://redirect.com" | egrep "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com" ||
       curl -Iks -m 10 "$line" -H "CF-Connecting_IP: redirect.com" -H "From: root@redirect.com" -H "Client-IP: redirect.com" -H "X-Client-IP: redirect.com" -H "X-Forwarded-For: redirect.com" -H "X-Wap-Profile: redirect.com" -H "Forwarded: redirect.com" -H "True-Client-IP: redirect.com" -H "Contact: root@redirect.com" -H "X-Originating-IP: redirect.com" -H "X-Real-IP: redirect.com" | egrep "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com";
    then
        echo -e "${RED}The URL $line with vulnerable header may be vulnerable to Open Redirection. Check Manually${NC}"
    else
        echo -e "${GREEN}No Open Redirect found on $line${NC}"
    fi
done < sub.txt
