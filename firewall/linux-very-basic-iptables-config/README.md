# Linux very basic iptables config

Very basic Iptables configuration script.

Firewall maintenance
-----------

First of all: do not loose connection.
Configure the crontab to reset the firewall while setting up the firewall.

Check if iptables-stop is OK:

```
# chmod +rx PATH_TO_SCRIPT/iptables-stop.sh
# PATH_TO_SCRIPT/iptables-stop.sh
# iptables -L
```

Edit /etc/crontab file and put the following configuration:

```
# Firewall maintenance
* * * * * root PATH_TO_SCRIPT/iptables-stop.sh
```

Installation
-----------

```
# cp linux-very-basic-iptables-config/firewall /etc/init.d/
# chmod +rx /etc/init.d/firewall
```
Ubuntu startup
-----------

```
# update-rc.d firewall defaults
```


