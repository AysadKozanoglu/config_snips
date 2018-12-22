This Howto explains howto integrate own custom Service Check for checking host based multiple domains

example:
```
        vars.urlsCheck = true
        vars.urls = "http://test1.com,https://test2.com,..."
```

icinga2 version : version: r2.7.1-1
check script path: /usr/lib/nagios/plugins/check_urls

### check_urls Script
```
#!/bin/bash
# author: Aysad Kozanoglu


   urls=$@
   WGET=$(which wget)
results=$(mktemp)"_resulturls"

# Split URLs by comma
   urls=${urls//,/ }

echo $urls >> /tmp/vars

for url in $urls
   do
      if [ "$(echo $url | cut -d: -f 1)" == "https" ]; then
        conntype="https"
      else
        conntype="http"
      fi
  	   # -t try connection x times
	   # -- timeout max execution 
	   # --connect-timeout  max request execution time
	    $WGET -t 2 --timeout=30 --connect-timeout=20 -q -O $(mktemp)"_checkUrl" $url && echo $url ok >> $results || echo $url NOK >> $results
done

if cat $results | grep "NOK" > /dev/null; then
       echo "Website  Failed:"
       cat $results | grep "NOK"
       EXITCODE=2
else
       echo -e "All URLs OK:"
       cat $results
       EXITCODE=0
fi

exit   $EXITCODE

```

### icinga2 Command Definition
/etc/icinga2/conf.d/commands.conf
```
object CheckCommand "urls_check" {
  import "plugin-check-command"

  command = [ PluginDir + "/check_urls" ]

  arguments = {
    " " = {
      value = "$urls$"
      description = "web adressen"
      required = true
    }
  }

  vars.webLink = "$address$"
}
```

### icinga2 Service Definition
```
apply Service "nrpe urls check" {
        import "generic-service"
        check_command = "urls_check"
        vars.urls = host.vars.urls

  assign where (host.address || host.address6) && host.vars.urlsCheck
}
```

### hosts variable set for urls check 
set urlsCheck=true and urls="http://test1.com,https://test2.com,..."

example

/etc/icinga2/conf.d/hosts/exampleHost.conf
```
vim /etc/icinga2/conf.d/hosts/exampleHost.conf

object Host "hostname-Example" {
        import "generic-host"
        address = "xxx.xxx.xxx.xxx"
        vars.os = "Linux"
        vars.sla = "24x7"
        vars.urlsCheck = true
        vars.urls = "http://test1.com,https://test2.com,..."
}
```
