#!/bin/bash
pkill hexo
hexo g
setsid hexo s > nohup.log &
echo "hexo server end"
