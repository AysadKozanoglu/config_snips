##SSL check with icinga2

icinga2 version: version: r2.7.1-1

###script path on icinga2:
/usr/lib/nagios/plugins/check_ssl_cert

###Create Script check_ssl_cert
```
wget -O /usr/lib/nagios/plugins/check_ssl_cert "https://git.io/fhJWq"
```

###Define Command ssl_check

/etc/icinga2/conf.d/commands.conf
```
object CheckCommand "ssl_check" {
  import "plugin-check-command"

  command = [ PluginDir + "/check_ssl_cert" ]

  arguments = {
    "-H" = {
      value = "$webLink$"
      description = "web adresse "
      required = true
    }
  }

  vars.webLink = "$address$"
}
```

### define Service "nrpe ssl"
```
apply Service "nrpe ssl" {
        import "generic-service"
        check_command = "ssl_check"
        vars.webLink = host.vars.webLink

  assign where (host.address || host.address6) && host.vars.os == "Linux"

}
```

### host configuration 
 to domain to check ssl set the variable weblink = domain.com in host configuration
 
 example:

/etc/icinga2/conf.d/hosts/exampleHost.conf
```
object Host "exampleHost" {
        import "generic-host"
        address = "xxx.xxx.xxx.xxx"
        vars.os = "Linux"
        vars.sla = "24x7"
        vars.webLink = "www.example.com"
}
```



