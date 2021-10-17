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

# 4. 修改站点文件（即blog文件夹下的文体）以达到访问username.github.io来访问我们blog的目的
> 1. 将下面内容添加至package.json（如果已经有就跳过）

```Json
{
    
  "scripts": {
    "build": "hexo generate"
  },
  ...
}
```

> 2. 新建.github/workflows/pages.yml，并添加如下内容：
```Yaml
name: Pages

on:
  push:
    branches:
      - source  # default branch

jobs:
  pages:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
        with:
          submodules: 'true' #敲重点，这里基本上没有已有教程会特意强调这里，这个with块，作用很大。详见附加内容1
      - name: Use Node.js 12.x
        uses: actions/setup-node@v1
        with:
          node-version: '12.x'
      - name: Cache NPM dependencies
        uses: actions/cache@v2
        with:
          path: node_modules
          key: ${{ runner.OS }}-npm-cache
          restore-keys: |
            ${{ runner.OS }}-npm-cache
      - name: Install Dependencies
        run: npm install
      - name: Build
        run: npm run build
      - name: Deploy
        uses: peaceiris/actions-gh-pages@v3
        with:
          github_token: ${{ secrets.GITHUB_TOKEN }}
          publish_dir: ./public
          publish_branch: master  # deploying branch
```
> 3. 将上述两步的修改，推送至git仓库的source分支。访问username.github.io就可以看到hexo的欢迎页了。

# 5. 更换theme（建站换主题要一气呵成嘛）
> 1. 选定一个自己喜欢的主题（直接在github搜索hexo-theme）
> 2. 本教程以换用material为demo，图为material的git主页： {% asset_img hexo-theme-material.jpg %}
> 3. 点击上图中fork按钮，fork至自己的仓库
> 4. git submodule init
> 5. git submodule add git@github.com:xxxxx/hexo-theme-material.git themes/material将我们fork出来的theme仓库，作为hexo的子模块（git链接为我们上面fork出来的仓库链接）
> 6. git submodule sync
> 7. git submodule update 上述两步将子模块内容拉取至本地
> 8. 修改_config.yml中theme: xxxx为theme: material，theme:后面跟的是git theme子模块的文件夹的名字
> 9. git add .&& git commit -m "change theme" && git push origin source将修改推送至git仓库，访问username.github.io看已经变成我们新更换的主题。

# 附加内容
## 1. 在.github/workflows/pages.yml中添加的with代码块:
我们在git仓库的source分支维护了hexo的源内容，包括本教程的后半部更换blog的theme，theme是在themes/文件夹下维护的，且通过本教程通过git submodule来维护其链接，那么在git pages的action行为中，单拉git仓的source分支，是缺失了themes文件夹下内容的下载的，那么添加的with代码块的作用就是：git action的时候将source分支和themes submodule都下载，后续的action才能执行，详细的action行为可以在git仓库的actions页签查看。