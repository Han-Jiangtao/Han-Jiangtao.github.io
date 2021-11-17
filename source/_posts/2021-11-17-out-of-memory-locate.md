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

首先还是怀疑是不是oom问题，需要通过信号量来实锤    
1.我尝试使用perf trace -e "kill"追踪signal，发现没有发送sigkill信号的行为    
2.尝试通过dmesg查看系统日志也没有发现sigkill信号    
3.现在我怀疑是不是我系统工具没有捕获到对应信号，自己又写了了简单的sleep脚本，手动发送kill -9信号，通过perf trace -e "kill"没有发现捕获到9信号    
4.查看perf trace help文档，使用perf trace -a跟踪所有trace，而不是单独的event，看到有捕获到9信号    
5.再次复现问题，perf trace -a依旧没有捕获到sig: kill信号    
6.dmesg同没有捕获到kill信号    

***未完***
