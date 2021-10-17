---
title: 2021-10-16-how-to-init-blog-by-hexo
post_title: 使用hexo和github搭建自己的blog
date: 2021-10-16 22:40:53
tags:
---
开始记录如何通过hexo和github搭建自己的blog
网上蛮多教程在如何发布blog和管理blog本身内容语焉不详，我写这个教程主要是将整个端到端流程记录下来，包括如何将自己买的域名解析至github pages

# 1.安装hexo（centos）
> 1. yum install npm 安装npm包管理器
> 2. npm config set registry https://registry.npm.taobao.org 配置npm源
> 3.npm install -g hexo 安装hexo

# 2.创建github个人pages仓库
> 1. 登陆github创建仓库，仓库名要为username.github.io {% img [git create] /_posts/2021-10-16-how-to-init-blog-by-hexo/git_pages_create.jpg [1776] [786] '"title text" "alt text"' %}
> 2. 这时github让开发者初始化仓库的界面如图：