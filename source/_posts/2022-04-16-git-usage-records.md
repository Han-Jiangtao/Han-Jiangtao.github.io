---
title: git_usage_records
date: 2022-04-16 12:41:24
tags:
 - [经验]
categories: 经验
---
## 使用git过程中的部分记录
# 代理
```bash
# git config --system
# 配置整个系统，全部用户操作生效
# 配置内容写入/etc/gitconfig

# git config --global
# 配置当前用户，当前用户全局操作生效
# 配置内容写入~/.gitconfig

# git config --local
# 配置当前git仓库，在当前git仓库生效
# 配置内容写入.git/config

# git config搜索顺序为.git/config->~/.git/config->/etc/gitconfig

# 配置代理,ip和port根据自己的目标服务器配置
git config --global https.proxy http://127.0.0.1:1080
git config --global https.proxy https://127.0.0.1:1080

# 关闭https的ssl验证
git config http.sslVerify "false"
# 或者可以使用如下方式单次不进行ssl验证并clone仓库
env GIT_SSL_NO_VERIFY=true git clone https://......git

# 取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy


```

# submodule
## 在一个git仓库里新引入submodule
## 拉取已有submodule的远程仓库并完成本地子模块拉取

