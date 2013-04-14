luci-app-vpnc
=============

Luci administration GUI for VPNC (Cisco VPN Concentrator Client)

Install instructions:

* Access LuCI interface and go to System > Software > Configuration
* Add a new line with the repository of the "luci-app-vpnc" package, like this:

```
src luci-app-vpnc http://openwrt.qui.guifi.net
```

![Adding a new repository](https://raw.github.com/tombatossals/luci-app-vpnc/master/images/opkg.conf.png)

* Update the list of packages with the new repository
* Search & Install the package "luci-app-vpnc"
* A new Tab Section "Services" will appear on your LuCI interface, go there and you will see the "VPNC" configuration section.
* The configuration usage is pretty self-explanatory.

![Update repository package list](https://raw.github.com/tombatossals/luci-app-vpnc/master/images/vpnc01.png)


