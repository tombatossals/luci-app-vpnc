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

s = m:section(TypedSection, "vpnc", translate("VPNC connection settings"))
s.anonymous = true

s:tab("vpnc",  translate("Connection Settings"))

gateway = s:taboption("vpnc", Value, "gateway", translate("Cisco VPN server hostname"))
gateway.datatype = "hostname"
s:taboption("vpnc", Value, "groupid", translate("Group ID"))
s:taboption("vpnc", Value, "secret", translate("Group Password"))
s:taboption("vpnc", Value, "username", translate("Username"))
pw = s:taboption("vpnc", Value, "password", translate("Password"))
pw.password = true

local pid = luci.util.exec("/usr/bin/pgrep vpnc")
local message = luci.http.formvalue("message")

function vpnc_process_status()
  local status = "VPNC is not running now and "

  if pid ~= "" then
      status = "VPNC is running with the PID " .. pid .. "and "
  end

  if nixio.fs.access("/etc/rc.d/S75vpnc") then
    status = status .. "it's enabled on the startup"
  else
    status = status .. "it's disabled on the startup"
  end

  local status = { status=status, message=message }
  local table = { pid=status }
  return table
end

t = m:section(Table, vpnc_process_status())
t.anonymous = true

t:option(DummyValue, "status", translate("VPNC status"))

if message then
  t:option(DummyValue, "message", translate("VPNC start message"))
end

if pid == "" then
  start = t:option(Button, "_start", translate("Start"))
  start.inputstyle = "apply"
  function start.write(self, section)
        message = luci.util.exec("/etc/init.d/vpnc start 2>&1")
        luci.util.exec("sleep 4")
        luci.http.redirect(
                luci.dispatcher.build_url("admin", "services", "vpnc") .. "?message=" .. message
        )
  end
else
  stop = t:option(Button, "_stop", translate("Stop"))
  stop.inputstyle = "reset"
  function stop.write(self, section)
        luci.util.exec("/etc/init.d/vpnc stop")
        luci.util.exec("sleep 4")
        luci.http.redirect(
                luci.dispatcher.build_url("admin", "services", "vpnc")
        )
  end
end

if nixio.fs.access("/etc/rc.d/S75vpnc") then
  disable = t:option(Button, "_disable", translate("Disable from startup"))
  disable.inputstyle = "remove"
  function disable.write(self, section)
        luci.util.exec("/etc/init.d/vpnc disable")
        luci.util.exec("sleep 1")
        luci.http.redirect(
                luci.dispatcher.build_url("admin", "services", "vpnc")
        )
  end
else
  enable = t:option(Button, "_enable", translate("Enable on startup"))
  enable.inputstyle = "apply"
  function enable.write(self, section)
        luci.util.exec("/etc/init.d/vpnc enable")
        luci.util.exec("sleep 1")
        luci.http.redirect(
                luci.dispatcher.build_url("admin", "services", "vpnc")
        )
  end
end

return m
