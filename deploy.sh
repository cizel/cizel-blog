rm -rf themes/*
git clone https://github.com/cizel/theme-even themes/even
hugo -t even -D --gc
