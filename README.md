# 说明

## 快速说明
> user: root
> 
> password: password
> 
> 192.168.8.1 (master branch)

## 开启wifi设置
由于lede lean大神的源码默认关闭了wifi所以开机没有wifi
如果有谁知道怎么默认开启并测试不报错，可以issue

修改配置文件`/etc/rc.local`

在exit 0前面添加

```shell
ifconfig ra0 up   #2G
ifconfig rai0 up  #5G
```

同时需要注意

Newifi D2默认配置，编辑LAN接口没有无线物理接口选择，保存后无线就关闭了，对比K2P，物理接口是有无线的
如果保存前，在自定义接口加上 "ra0 rai0"，再点击保存并应用，无线就不会关闭

参考[issu](https://github.com/coolsnowwolf/lede/issues/8259)



![image](https://user-images.githubusercontent.com/8328013/141735800-bc5751af-7e19-44bc-b9c3-1d9f13eada4f.png)



## 其他说明

官方openwrt最新测试内核5.15的编译！
集成全部USB网卡驱动，支持安卓USB共享网络！
精简仅集成如下（参考）

CONFIG_PACKAGE_luci-app-adguardhome=y

CONFIG_PACKAGE_luci-app-easymesh=y

CONFIG_PACKAGE_luci-app-frpc=y

CONFIG_PACKAGE_luci-app-frps=y

CONFIG_PACKAGE_luci-app-guest-wifi=y

CONFIG_PACKAGE_luci-app-jd-dailybonus=y

CONFIG_PACKAGE_luci-app-mwan3=y

CONFIG_PACKAGE_luci-app-ntpc=y

CONFIG_PACKAGE_luci-app-openclash=y

CONFIG_PACKAGE_luci-app-passwall=y

CONFIG_PACKAGE_luci-app-pptp-server=y

CONFIG_PACKAGE_luci-app-pushbot=y

CONFIG_PACKAGE_luci-app-qos=y

CONFIG_PACKAGE_luci-app-smartdns=y

CONFIG_PACKAGE_luci-app-sqm=y

CONFIG_PACKAGE_luci-app-syncdial=y

CONFIG_PACKAGE_luci-app-ttyd=y

CONFIG_PACKAGE_luci-app-udpxy=y

CONFIG_PACKAGE_luci-app-uhttpd=y

CONFIG_PACKAGE_luci-app-usb-printer=y

CONFIG_PACKAGE_luci-app-wifischedule=y

CONFIG_PACKAGE_luci-app-wireguard=y

AP版本仅有passwall,smartdns,usb共享，clash。
