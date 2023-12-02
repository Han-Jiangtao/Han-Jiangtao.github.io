#!/bin/bash
pkill hexo
hexo clean
hexo g
setsid hexo s -p 10012 > nohup.log &
echo "hexo server end"
