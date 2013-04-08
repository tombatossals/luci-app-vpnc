--[[
LuCI - Lua Configuration Interface

Copyright 2008 Steven Barth <steven@midlink.org>
Copyright 2008 Jo-Philipp Wich <xm@leipzig.freifunk.net>

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

	http://www.apache.org/licenses/LICENSE-2.0

$Id: vpnc.lua 6984 2011-04-13 15:14:42Z soma $
]]--

m = Map("vpnc", translate("VPNC"))

s = m:section(TypedSection, "general", translate("VPNC General Settings"))
s.anonymous = true

s:tab("general",  translate("General Settings"))
s:tab("template",  translate("Template"))

s:taboption("general", Value, "gateway", translate("Cisco VPN server hostname"))
s:taboption("general", Value, "groupid", translate("Group ID"))
s:taboption("general", Value, "secret", translate("Group Password"))
s:taboption("general", Value, "username", translate("Username"))
pw = s:taboption("general", Value, "password", translate("Password"))
pw.password = true

s = m:section(TypedSection, "status", translate("VPNC status"))
s.anonymous = true
start = s:option(Button, "start", translate("Start"))
start.inputstyle = "apply"
start.write = function(self, section)
        luci.sys.call("/etc/init.d/vpnc %s >/dev/null" %{ self.option })
end

stop = s:option(Button, "stop", translate("Stop"))
stop.inputstyle = "remove"
stop.write = start.write

function m.on_commit(map)
	# Write file
end

return m
