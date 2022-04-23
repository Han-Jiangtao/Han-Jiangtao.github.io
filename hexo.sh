#!/bin/bash
pkill hexo
hexo g
setsid hexo s -p 10004 > nohup.log &
echo "hexo server end"
