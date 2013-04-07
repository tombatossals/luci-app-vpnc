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

s = m:section(TypedSection, "vpnc", "VPNC")
s.anonymous = true

s:tab("general",  translate("General Settings"))

s:taboption("general", Value, "gateway", translate("Cisco VPN server hostname"))
s:taboption("general", Value, "id", translate("Group ID"))
s:taboption("general", Value, "secret", translate("Group Password"))
s:taboption("general", Value, "username", translate("Username"))
s:taboption("general", Value, "password", translate("Password"))

s = m:section(TypedSection, "status", translate("VPNC status"))
s.anonymous = true

return m
