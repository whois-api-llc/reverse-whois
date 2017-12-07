$uri = "https://www.whoisxmlapi.com/reverse-whois-api/"`
        +"search.php?mode=preview"`
        +"&term1=wikimedia"`
        +"&username=your_reverse_whois_api_username&password=your__reverse_whois_api_password"`
        +"&outputFormat=json"


$j = Invoke-WebRequest -Uri $uri
echo "JSON:`n---" $j.content "`n"