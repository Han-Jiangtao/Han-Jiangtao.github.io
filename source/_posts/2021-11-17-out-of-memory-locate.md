---
title: 定位linux应用oom问题
date: 2021-11-17 21:28:58
tags:
- [linux, oom]
- [经验]
---

我运行一个程序在服务器上，没有core文件产生，且程序异常退出，退出码为137（128+9）   
那么意味着我的程序，收到了一个kill -9信号，但是我十分确认的是，没有主动的去发送此信号    
google一下，大家遇到的exit code为137的问题多为oom（out of memory）我的环境是ubuntu x86_64内存1.5TB.    
ulimit -a查看max memory size为unlimited状态，且复现问题内存占用率较低，大概占了300GB左右    

1117记录跟进<br>
首先还是怀疑是不是oom问题，需要通过信号量来实锤<br>
1.我尝试使用perf trace -e "kill"追踪signal，发现没有发送sigkill信号的行为<br>
2.尝试通过dmesg查看系统日志也没有发现sigkill信号<br>
3.现在我怀疑是不是我系统工具没有捕获到对应信号，自己又写了了简单的sleep脚本，手动发送kill -9信号，通过perf trace -e "kill"没有发现捕获到9信号<br>
4.查看perf trace help文档，使用perf trace -a跟踪所有trace，而不是单独的event，看到有捕获到9信号<br>
5.再次复现问题，perf trace -a依旧没有捕获到sig: kill信号<br>
6.dmesg同没有捕获到kill信号<br>

1118记录跟进<br>
oom依旧是怀疑方向<br>
大哥帮忙找了一个[大牛的脚本](https://github.com/brendangregg/perf-tools)，进程内通信的signal全部能采集到，包括python的os.kill发送的0，但是唯独收到kill信号的主进程的这个信号没有捕获迹象<br>
重新试图使用/sys/kernel/debug/tracing配置捕捉deliver和gengerate的signal，第一次尝试也是唯独没有捕获到主进程消失的kill信号

***未完***
