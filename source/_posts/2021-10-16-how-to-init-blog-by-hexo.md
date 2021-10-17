---
title: 使用hexo和github搭建自己的blog
post_title: 使用hexo和github搭建自己的blog
date: 2021-10-16 22:40:53
tags:
---
开始记录如何通过hexo和github搭建自己的blog
网上蛮多教程在如何发布blog和管理blog本身内容语焉不详，我写这个教程主要是将整个端到端流程记录下来，包括如何将自己买的域名解析至github pages

# 1. 安装hexo（centos）
> 1. yum install npm 安装npm包管理器
> 2. npm config set registry https://registry.npm.taobao.org 配置npm源
> 3.npm install -g hexo 安装hexo

# 2. 创建github个人pages仓库
> 1. 登陆github创建仓库，仓库名要为username.github.io 如图：{% asset_img git_pages_create.jpg %}
> 2. 这时github让开发者初始化仓库的界面如图：{% asset_img git_init.jpg %}
> 3. 完成上面两步，在git网站的操作也结束了，不用着急按照网站上提示初始化仓库，后续我们直接将hexo相关内容上传初始化网站
> 4. 另外，本教程默认已经完成了你自己host的git环境已经ready，不再赘述安装git和ssh-key的添加

# 3. 本地hexo内容
> 1. mkdir -p blog创建工作目录
> 2. cd blog进入工作目录
> 3. hexo init初始化hexo内容
> 4. git init初始化git仓库如上2.2图片
> 5. git add .
> 6. git commit -m "blog init"
> 7. git branch -M source将源文件提交到source分支，后续gitpages在master分支展现
> 8. git remote add origin git@github.com:xxxx.git最后的这个git链接为2.2操作git网站的你自己的git仓链接
> 9. git push -u origin source 将hexo init完的内容推送至git仓库