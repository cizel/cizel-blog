git submodule update --init --recursive
hugo -t casper
rsync -avz ./public/ /home/work/data/www/www.cizel.cn/
