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

修改配置文件`/etc/rc.local`(已经默认配置)

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

## 校园网 Srun 深澜认证登录（参考）

[教程参考](https://zhuanlan.zhihu.com/p/551332214)

自动认证登录参考[博客](https://blog.csdn.net/qq248606117/article/details/125144699)

自动认证参考的的github[项目](https://github.com/zu1k/sdusrun)rust编写，有能力的同学可以后续搞个openwrt插件，搞个界面自动登录。代表广大师生感谢。

这个newifi3下载版本使用`sdusrun-mipsel-unknown-linux-musl`即可，是mipsel架构

为什么用这个项目，1. rust写的安全性好 2. 编译的二进制文件很小，500k左右，golang版本太大了。奈何newifi3内存只有32M闪存。golang的[版本](https://github.com/hstable/SRUN_LOGIN)好像支持自动重连。不需要写脚本。

自动登录脚本参考: `ping.sh`

```shell
crontab -e
*/1 * * * * bash /root/ping.sh
service cron restart # 设置定时任务重启服务
```



## tailscale配置参考

### 命令行登录tailscale

```shell
tailscale up --login-server=http://<URL>:8080 --accept-routes --accept-dns=false --advertise-routes=192.168.8.0/24 --advertise-exit-node
```

### 添加网口

网络-接口-添加新结构

名称ts0 静态路由 添加tailscale客户端分配的ip （命令行查询方式:tailscale ip）

子网掩码：

官方填：255.0.0.0

自建服务器：255.255.255.0

网关填路由器网关：192.168.8.1（默认）

广播：192.168.8.255

DNS：114.114.114.114

防火墙区域添加至`LAN`

### openwrt 开启转发（已经默认集成固件）

```shell
echo 'net.ipv4.ip_forward = 1' | tee /etc/sysctl.d/ipforwarding.conf
echo 'net.ipv6.conf.all.forwarding = 1' | tee -a /etc/sysctl.d/ipforwarding.conf
sysctl -p /etc/sysctl.d/ipforwarding.conf
```

防火墙-常规设置-转发-接受

区域：lan转发wan全部接受

## 手动添加包
```shell
alist
rclone
filebrowser
qBittorrent
```

## 升级内核(手动)

```shell
cd /tmp
wget https://downloads.openwrt.org/snapshots/targets/ramips/mt7621/packages/kernel_5.10.
131-1-912e65070c8d5fe2f65fc191f37e61f2_mipsel_24kc.ipk
opkg install 
```

## 添加软件源

```shell
sed -i 's/option check_signature//g' /etc/opkg.conf
echo 'src/gz openwrt_kiddin9 https://op.supes.top/packages/mipsel_24kc' >> /etc/opkg/distfeeds.conf
```
https://downloads.openwrt.org/snapshots/targets/ramips/mt7621/packages/
## qbittorrent 安装

感谢静态编译的[仓库](https://github.com/jsp1256/qBittorrent_cross_complie)

依赖装的太麻烦,直接下载静态[二进制文件](https://github.com/jsp1256/qBittorrent_cross_complie/blob/master/bin/4.4.0/qbittorrent-nox)


## 其他说明

官方openwrt最新测试内核5.15的编译！
集成全部USB网卡驱动，支持安卓USB共享网络！
精简仅集成如下（参考）

精简版，添加源 https://op.supes.top/packages/mipsel_24kc
按需安装
默认集成源中没有的tailscale
其余按需opkg install 即可

```shell
CONFIG_PACKAGE_luci-app-socat=y
CONFIG_PACKAGE_uugamebooster=y
CONFIG_PACKAGE_luci-app-uugamebooster=y
CONFIG_PACKAGE_nginx-all-module=y
CONFIG_PACKAGE_luci-app-nginx-manager=y
CONFIG_PACKAGE_e2fsprogs=y
CONFIG_PACKAGE_fdisk=y
CONFIG_PACKAGE_ddns=y
CONFIG_PACKAGE_luci-app-ddns=y
CONFIG_PACKAGE_luci-i18n-ddns-zh-cn=y
CONFIG_PACKAGE_ddns-scripts=y
CONFIG_PACKAGE_ddns-scripts_aliyun=y
CONFIG_PACKAGE_ddns-scripts_dnspod=y
CONFIG_PACKAGE_hd-idle=y
CONFIG_PACKAGE_luci-app-hd-idle=y
CONFIG_PACKAGE_luci-app-pushbot=y
CONFIG_PACKAGE_tailscale=y
CONFIG_PACKAGE_tailscaled=y
CONFIG_PACKAGE_luci-app-samba=y
CONFIG_PACKAGE_smartdns=y
CONFIG_PACKAGE_luci-app-smartdns=y
CONFIG_PACKAGE_luci-app-sqm=y
CONFIG_PACKAGE_ttyd=y
CONFIG_PACKAGE_luci-app-ttyd=y
CONFIG_PACKAGE_luci-app-uhttpd=y
CONFIG_PACKAGE_luci-app-upnp=y
CONFIG_PACKAGE_luci-app-wol=y
CONFIG_PACKAGE_passwall=y
CONFIG_PACKAGE_luci-app-passwall=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_ShadowsocksR_Libev_Server=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray=y
CONFIG_PACKAGE_luci-app-passwall_INCLUDE_V2ray_Plugin=y
CONFIG_PACKAGE_ntpc=y
CONFIG_PACKAGE_luci-app-ntpc=y
CONFIG_PACKAGE_luci-app-dnsfilter=y
```
