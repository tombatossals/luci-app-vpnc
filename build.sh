#!/bin/sh

mkdir -p dist
cp -va src/* dist
mkdir -p dist/CONTROL
cat >dist/CONTROL/control <<EOF
Package: luci-app-vpnc
Version: 0.1
Architecture: mipsel
Maintainer: David Rubert <david.rubert@gmail.com>
Section: luci
Priority: optional
Description: LuCI GUI to the VPNC program
Source: http://github.com/tombatossals/luci-app-vpnc
EOF
ipkg-build -o root -g root dist /tmp
