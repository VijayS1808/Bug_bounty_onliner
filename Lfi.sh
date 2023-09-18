cat clean_urls.txt | while read url; do
    if curl -s "$url" 2>&1 | grep -q "root:x"; then
        echo -e "\e[31mVULN! $url\e[0m"  # This will print "VULN!" in red
    else
        echo -e "\e[32mNot Vulnerable: $url\e[0m"  # This will print "Not Vulnerable" in green
    fi
done
