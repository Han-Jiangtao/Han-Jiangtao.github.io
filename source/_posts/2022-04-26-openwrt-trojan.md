---
title: openwrt_trojan
date: 2022-04-26 20:22:04
tags:
 - [环境搭建]
categories: 折腾
---
# 树莓派搭建家庭科学上网旁路由
家里有多台设备有科学上网诉求，但是配置只允许2个设备接入。来回切换体验很差劲，手头有个树莓派也省的额外购买。</br>
梅林之前已经搞过一次，兴趣不大，另外现在论坛暂未支持trojan插件，所以放弃。</br>
openwrt已经有trojan插件且有github每日编译，配置也不复杂，完成了图形化配置所以选型用openwrt。</br>

当前家里路由及设备连接如图所示:
![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/family_route_demo.png)

# 1.镜像准备
感谢@SuLingGG 每日构建openwrt镜像.</br>
仓库地址:[https://github.com/SulingGG/Openwrt-rpi](https://github.com/SulingGG/Openwrt-rpi)</br>
下载地址:[https://doc.openwrt.cc/2-OpenWrt-Rpi/1-Download/](https://doc.openwrt.cc/2-OpenWrt-Rpi/1-Download/)</br>
当前已支持设备可以在下载地址查看，树莓派系列都有支持下载，我这边使用了3B的squashfs-sysupgrade.img.gz镜像</br>

# 2.烧录镜像
准备一张4G以上的SD卡，使用SD Card Formatter擦除SD卡。</br>
使用balenaEther，烧写镜像![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/balenaEther_flash.png)
烧录完成后插入树莓派的SD卡槽，网线暂时不要连接到路由器上。</br>

# 3.OpenWrt配置
网上教程一般推荐用网线将树莓派和PC相连，然后登录OpenWrt的配置界面进行配置，当然下述方式不成功的话，树莓派与PC直连效果一样。</br>
当下我们选择另外的方式，SD卡烧录完成并放进树莓派后启动树莓派，手机即可搜到OpenWrt名字的wifi。
大概过3-5min让树莓派完成配置，wifi连接到对应网络上。手机查看当前wifi信息可以看到网段为192.168.1.xx，网关为192.168.1.1</br>
手机浏览器登录192.168.1.1，用户名密码默认为root/password。
登录进后，选择网络分类接口：
点击lan修改：配置成如下(注意配置项的ipv4相关网段均为主路由的网段)

保存并应用后，将主路由和树莓派网线连接，可以在主路由器上发现，ipv4为我们配置的设备。</br>
重启树莓派</br>

在PC上打开我们设置的树莓派的ipv4地址

