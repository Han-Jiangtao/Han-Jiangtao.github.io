---
title: 树莓派刷机openwrt配置trojan
date: 2022-04-26 20:22:04
tags:
 - [环境搭建]
categories: 折腾
---
# 树莓派搭建家庭科学上网旁路由
以下任何行为均需要在合法合规的前提下进行。</br>
知法懂法！！！！本教程以阿里云代理为前提，无任何违法行为和倾向。</br>
家里有多台设备有科学上网诉求，但是配置只允许2个设备接入。来回切换体验很差劲，手头有个树莓派也省的额外购买。</br>
梅林之前已经搞过一次，兴趣不大，另外现在论坛暂未支持trojan插件，所以放弃。</br>
openwrt已经有trojan插件且有github每日编译，配置也不复杂，完成了图形化配置所以选型用openwrt。</br>

当前家里路由及设备连接如图所示:</br>
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
![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/openwrt_network_interface.jpeg)</br>
明显上图中192.168.50.1为我们主路由ip，则本例中旁路由ipv4地址为192.168.50.2，并且在旁路由上关闭了DHCP服务</br>
保存并应用后，将主路由和树莓派网线连接，可以在主路由器上发现，对应的ipv4地址分配给了我们配置的设备。</br>
重启树莓派</br>

在PC上打开我们设置的树莓派的ipv4地址192.168.50.2(root/password)</br>
进入服务->ssr->服务器节点，将自己的trojan订阅链接填入，如下图:
![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/openwrt_ssr_server_url.jpeg)
订阅成功后界面会有下图信息:
![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/openwrt_success_add_ssr_server.jpeg)
点击保存后，可以进入下图界面进行连通性确认:
![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/openwrt_trojan_connect_success.jpeg)
上图即为链接可访问，到此旁路由的设置完成。

# 4.手机wifi默认代理
我手边手机一般连接主卧的二级中继路由，手头是iphone(Android同理)</br>
将手机连接至wifi后，将ipv4手动配置，由于iphone都在一起，所以ip、dns、gateway统一配置</br>
ip配置为本身原来的即可(链接好wifi后，详细界面可以看到)</br>
dns配置为旁路由ip，gateway配置为旁路由ip。
全部配置完成后，如下两图:
![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/openwrt_iphone_ipv4.jpg)
![](https://cdn.jsdelivr.net/gh/Han-Jiangtao/picgo/img/openwrt_iphone_dns.jpg)
以上，即为手机端配置走旁路由代理的方法。

# 5.PC端配置默认走旁路由代理
同手机端，ip设为dhcp本身给的ip，dns和gateway走旁路由即可
