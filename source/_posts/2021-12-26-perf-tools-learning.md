---
title: 学习使用linux perf工具
date: 2021-12-26 22:01:28
tags:
- [经验]
---
本章记录学习使用perf工具的过程,以centos x86环境测试

安装perf：sudo yum install perf

# perf简单介绍

perf --help可以查看perf支持的比较常用的参数列表及其功能
|参数列表|功能|
|:---:|:---:|
|annotate|Read perf.data (created by perf record) and display annotated code|
|archive|Create archive with object files with build-ids found in perf.data file|
|bench|General framework for benchmark suites|
|buildid-cache|Manage build-id cache.|
|buildid-list|List the buildids in a perf.data file|
|c2c|Shared Data C2C/HITM Analyzer.|
|config|Get and set variables in a configuration file.|
|data|Data file related processing|
|diff|Read perf.data files and display the differential profile|
|evlist|List the event names in a perf.data file|
|ftrace|simple wrapper for kernel's ftrace functionality|
|inject|Filter to augment the events stream with additional information|
|kallsyms|Searches running kernel for symbols|
|kmem|Tool to trace/measure kernel memory properties|
|kvm|Tool to trace/measure kvm guest os|
|list|List all symbolic event types|
|lock|Analyze lock events|
|mem|Profile memory accesses|
|record|Run a command and record its profile into perf.data|
|report|Read perf.data (created by perf record) and display the profile|
|sched|Tool to trace/measure scheduler properties (latencies)|
|script|Read perf.data (created by perf record) and display trace output|
|stat|Run a command and gather performance counter statistics|
|test|Runs sanity tests.|
|timechart|Tool to visualize total system behavior during a workload|
|top|System profiling tool.|
|version|display the version of perf binary|
|probe|Define new dynamic tracepoints|
|trace|strace inspired tool|

## perf record
采集要分析的原始数据</br>
根据man perf-record查看其基本使用方法</br>
可以分为三个大区域</br>
默认前缀：perf record</br>
record option（可选）: -g etc.</br>
command（为指定要采集的程序，如果使能本部分，则部分全局采集record option不可用）</br>
e.g.
```bash
perf record -g -a #监控全部CPU,使能调用关系图
perf record -g ./myapp myapp_arg1 myapp_arg2 #监控myapp，使能调用关系图
```



```未完```