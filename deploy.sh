rm -rf themes/*
git clone https://github.com/cizel/theme-even themes/even
hugo -t even
rsync -avz ./public/ /home/work/data/www/www.cizel.cn/
