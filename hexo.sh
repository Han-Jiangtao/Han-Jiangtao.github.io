#!/bin/bash
pkill hexo
hexo g
setsid hexo s > nohup.log
