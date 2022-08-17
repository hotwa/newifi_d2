#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part1.sh
# Description: OpenWrt DIY script part 1 (Before Update feeds)
#

# Uncomment a feed source
#sed -i 's/^#\(.*helloworld\)/\1/' feeds.conf.default

# Add a feed source
echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
sed -i '$a src-git kenzo https://github.com/kenzok8/openwrt-packages' feeds.conf.default
sed -i '$a src-git small https://github.com/kenzok8/small-package' feeds.conf.default
sed -i '$a src-git liuran001_packages https://github.com/liuran001/openwrt-packages' feeds.conf.default
sed -i '$a src-git coolsnowwolf_packages https://github.com/coolsnowwolf/packages' feeds.conf.default
sed -i '$a src-git coolsnowwolf_luci https://github.com/coolsnowwolf/luci' feeds.conf.default
#sed -i '$a src-git kiddin9 https://github.com/kiddin9/openwrt-packages' feeds.conf.default

# add dts file
mv jdc_re-cp-02.dts ./target/linux/ramips/dts/jdc_re-cp-02.dts
# ./target/linux/ramips/image/mt7621.mk
cat << EOF >> target/linux/ramips/image/mt7621.mk 
define Device/jdc_re-cp-02
  $(Device/uimage-lzma-loader)
  IMAGE_SIZE := 16064k  
  DEVICE_VENDOR := JDCloud
  DEVICE_MODEL := re-cp-02
  DEVICE_COMPAT_VERSION := 1.0
  DEVICE_PACKAGES := kmod-mt7603e kmod-mt76x2e kmod-usb3 kmod-usb-ledtrig-usbport luci-app-mtwifi \
        kmod-sdhci kmod-sdhci-mt7620 -wpad-openssl
endef
TARGET_DEVICES += jdc_re-cp-02
EOF
# ./target/linux/ramips/base-files/lib/upgrade/platform.sh
# 最后生成的固件在目录

# ./bin/targets/ramips/mt7621/