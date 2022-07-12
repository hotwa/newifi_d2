#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)

# Modify default IP
sed -i 's/192.168.1.1/192.168.8.1/g' package/base-files/files/bin/config_generate

#修正连接数（by ベ七秒鱼ベ）
sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf
sed -i '$a net.ipv4.ip_forward = 1' package/base-files/files/etc/sysctl.conf
sed -i '$a net.ipv4.ip_forward = 1' package/base-files/files/etc/sysctl.conf
sed -i '$a net.ipv6.conf.all.forwarding = 1' package/base-files/files/etc/sysctl.conf

# themes添加（svn co 命令意思：指定版本如https://github）
git clone https://github.com/xiaoqingfengATGH/luci-theme-infinityfreedom package/luci-theme-infinityfreedom
git clone https://github.com/Leo-Jo-My/luci-theme-opentomcat.git package/luci-theme-opentomcat
git clone https://github.com/openwrt-develop/luci-theme-atmaterial.git package/luci-theme-atmaterial
git clone https://github.com/kiddin9/luci-app-dnsfilter.git package/luci-app-dnsfilter

# add turbo
git clone https://github.com/jolababa214/luci-app-flowoffload-2.git
git clone https://github.com/zxl78585/luci-app-filetransfer.git package/luci-app-filetransfer

#git clone https://github.com/kenzok8/openwrt-packages.git package/openwrt-packages

#添加额外软件包

git clone https://github.com/destan19/OpenAppFilter.git package/OpenAppFilter
rm -rf package/luci-app-pushbot && git clone https://github.com/zzsj0928/luci-app-pushbot.git package/luci-app-pushbot
git clone https://github.com/riverscn/openwrt-iptvhelper.git package/openwrt-iptvhelper

#sirpdboy
rm -rf package/luci-app-autotimeset && git clone https://github.com/sirpdboy/luci-app-autotimeset package/luci-app-autotimeset
rm -rf package/luci-app-netdata && git clone https://github.com/sirpdboy/luci-app-netdata package/luci-app-netdata
git clone https://github.com/sirpdboy/luci-theme-opentopd package/luci-theme-opentopd
#git clone 
#git clone 
#git clone 
##由于习惯问题，会和LEAN大中的automount冲突 ，建议编译前先删除：rm -rf package/lean/automount
rm -rf package/autosamba && git clone https://github.com/sirpdboy/autosamba.git package/autosamba
rm -rf package/automount && git clone https://github.com/sirpdboy/automount.git package/automount
rm -rf package/netspeedtest && git clone https://github.com/sirpdboy/netspeedtest.git package/netspeedtest
rm -rf package/luci-app-netdata && git clone https://github.com/sirpdboy/luci-app-netdata.git package/luci-app-netdata
# sirpdboy 仓库选择克隆，直接做feeds编译报错
# mkdir opentopd/
# git clone https://github.com/sirpdboy/koolddns opentopd/
# rm -rf package/koolddns && mv opentopd/koolddns package/koolddns
# rm -rf luci-app-koolddns && mv opentopd/luci-app-koolddns package/luci-app-koolddns
# rm -rf opentopd

# for test 
#Pikpak
# svn co https://github.com/ykxVK8yL5L/pikpak-webdav/trunk/openwrt package/luci-app-pikpak-webdav
#Axum-web
# svn co https://github.com/ykxVK8yL5L/axum-web/trunk/openwrt package/luci-app-axum-web

#Alist
# git clone https://github.com/sbwml/openwrt-alist/luci-app-alist.git package/luci-app-alist
# git clone https://github.com/sbwml/openwrt-alist/alist.git package/alist
svn co https://github.com/sbwml/openwrt-alist/trunk package/luci-app-alist
mv package/luci-app-alist/luci-app-alist/po/zh_Hans package/luci-app-alist/luci-app-alist/po/zh-cn
