#
# Copyright (C) 2008 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#
# $Id$

include $(TOPDIR)/rules.mk

PKG_NAME:=luci-app-vpnc
PKG_RELEASE:=1

include $(INCLUDE_DIR)/package.mk

define Package/luci-app-vpnc
 SECTION:=utils
 CATEGORY:=Utilities
 TITLE:=Luci interface to the VPNC tunnel program
endef

define Build/Prepare
 mkdir -p $(PKG_BUILD_DIR)
 $(CP) ./src/* $(PKG_BUILD_DIR)/
endef

define Build/Configure
endef

define Build/Compile
 $(MAKE) -C $(PKG_BUILD_DIR) $(TARGET_CONFIGURE_OPTS)
endef

define Package/luci-app-vpnc/install
 $(INSTALL_DIR) $(1)/bin
 $(INSTALL_BIN) $(PKG_BUILD_DIR)/luci-app-vpnc $(1)/bin/
endef

$(eval $(call BuildPackage,luci-app-vpnc))
