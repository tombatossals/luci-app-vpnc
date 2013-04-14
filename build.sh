#!/bin/sh

mkdir -p dist
cp -va src/* dist
mkdir -p dist/CONTROL
cat >dist/CONTROL/control <<EOF
Package: luci-app-vpnc
Version: 0.1
Architecture: all
Maintainer: David Rubert <david.rubert@gmail.com>
Section: luci
Depends: vpnc
Priority: optional
Description: LuCI GUI to the VPNC program
Source: luci-app-vpnc
EOF
opkg-build -o root -g root dist /tmp
