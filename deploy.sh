git submodule update --init --recursive
hugo -t jane
rsync -avz ./public/ /home/work/data/www/www.cizel.cn/
