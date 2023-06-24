# SQL Injection:

cat sql | grep ".php" | sed 's/.php.*/.php/' | sort -u | sed 's|$|%27%22%60|' | while read url ; do curl --silent "$url" | grep -qs "You have an error in your SQL syntax" && echo -e "$url \e[1;32mVulnerable\e[0m" || echo -e "$url \e[1;31mNot Vulnerable\e[0m" ; done

 
 cat urls.txt | grep ".php" | sed 's/\.php.*/.php\//' | sort -u | sed s/$/%27%22%60/ | httpx -silent -ms "You have an error in your SQL syntax"

## Sensitive information disclosure throgh JS files:

cat *js | grep -r -E "aws_access_key|aws_secret_key|api key|passwd|pwd|heroku|slack|firebase|swagger|aws_secret_key|aws key|password|ftp password|jdbc|db|sql|secret jet|config|admin|pwd|json|gcp|htaccess|.env|ssh key|.git|access key|secret token|oauth_token|oauth_token_secret" /path/to/directory/*.js


## Extract urls from JS files:

cat *.js | grep -aoP "(?<=('|\`|\"))(/[a-zA-Z0-9_?&=/\-#.]*?)(?=('|\`|\"))" | sort -u


## Download js files from whole js.txt files:

#!/bin/bash

while IFS= read -r url; do
    echo "Downloading: $url"
    wget "$url" -P  /home/vijay/Desktop/Bug_Bounty/nasa/JS
done < alivejs.txt





