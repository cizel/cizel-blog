rm -rf ./themes/*
git submodule update --init --recursive
hugo -t even
rsync -avz ./public/ /home/work/data/www/www.cizel.cn/
