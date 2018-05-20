---
title: "Shell 脚本编程实践"
date: 2018-05-20T12:38:57+08:00
lastmod: 2018-05-20T12:38:57+08:00
draft: false
keywords: ["Linux", "Shell Script"]
description: ""
tags: []
categories: ["最佳实践"]
---

Linux Shell 脚本编程之前一直没有系统的去学习, 在写 Shell 脚本的时候总需要现查各种语法. 本文章以编程语言的维度去系统的学习 Shell 脚本编程.

<!--more-->

## Shell

Linux Shell 是与 Linux 系统交互的一个应用程序, 我们通过这个程序可以操作 Linux 系统的内核服务.

执行 `$cat /etc/shells`, 可以看到系统中现在可用的 Shell 解释器

```bash
# List of acceptable shells for chpass(1).
# Ftpd will not allow users to connect who are not using
# one of these shells.

/bin/bash
/bin/csh
/bin/ksh
/bin/sh
/bin/tcsh
/bin/zsh
/usr/local/bin/zsh
```

现代的 Linux 系统中 `/bin/sh` 已经被 `/bin/bash`, 作为 Linux 默认的 Shell. 

输入 `$echo $SHELL` 可以看到当前系统的 Shell.

## Shell 脚本

Shell 脚本(Shell Script), 是为 Shell 编写的一个脚本程序. 我们说的 Shell 通常指的是 Shell 脚本. 

## Shell 变量

Shell 脚本属于弱类型的脚本语言, 在使用的时候不需要提前定义变量类型. 

直接赋值的方式: 

<font color="green">[正确]</font> name="cizel"

<font color="red">[错误]</font> $name<kbd>空格</kbd>=<kbd>空格</kbd>"cizel" *赋值变量不能有 $ 符号, 等号不能有空格*


另外一种语句的赋值方式: 

```bash
for file in `ls /etc`
```

## 未完, 待续

## 相关链接 

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [linux几种常见的Shell](https://blog.csdn.net/whatday/article/details/78929247)
- [Shell脚本编程30分钟入门](https://github.com/qinjx/30min_guides/blob/master/shell.md)
let g:vim_markdown_no_default_key_mappings = 1
