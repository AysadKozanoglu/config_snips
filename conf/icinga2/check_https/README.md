## check HTTPS with icinga2
version: version: r2.7.1-1

script path:
/usr/lib/nagios/plugins/check_http  (comes with default installation of nagios als plugins)

### define custom Command for https check
```
object CheckCommand "newhttps_check" {
  import "plugin-check-command"

  command = [ PluginDir + "/check_http" ]

  arguments = {
    "-s" = {
      value = "$webLink$"
      description = "web adresse "
      required = true
    }

  }

  vars.webLink = "$address$"
}

```

### define Service for https 
```
apply Service "nrpe https check" {
        import "generic-service"
        check_command = "newhttps_check"
        vars.webLink = host.vars.webLink
        vars.check_interval = 1m
        vars.retry_interval = 300s
  assign where (host.address || host.address6) && host.vars.os == "Linux"  // && !host.vars.noSSL
}

```

### host configuration
set the variable within host.conf 
        vars.webLink = "www.example.com"
        
example:
```
object Host "exampleHost" {
        import "generic-host"
        address = "xxx.xxx.xxx.xxx"
        vars.os = "Linux"
        vars.sla = "24x7"
//        vars.noSSL = true
        vars.webLink = "example.com"
}

```


