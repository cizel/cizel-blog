---
title: "Shell 脚本编程基础 30%"
date: 2018-05-20T12:38:57+08:00
lastmod: 2018-05-23T12:38:57+08:00
draft: false
keywords: ["Linux", "Shell Script"]
description: ""
tags: []
categories: ["Linux"]
---

Linux Shell 脚本编程之前一直没有系统的去学习，在写 Shell 脚本的时候总需要现查各种语法。本文章以编程语言的维度去系统的学习 Shell 脚本编程。

<!--more-->

## Shell

Linux Shell 是与 Linux 系统交互的一个应用程序，我们通过这个程序可以操作 Linux 系统的内核服务。

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

Shell 脚本 (Shell Script), 是为 Shell 编写的一个脚本程序。我们说的 Shell 通常指的是 Shell 脚本。

## Shell 变量

Shell 脚本属于弱类型的脚本语言，在使用的时候不需要提前定义变量类型。

> 可能的坑：

> 1. 赋值变量不能有美元符号 (`$`)
> 2. 赋值语句等号 (`=`) 左右都不能有空格


### 变量定义

```bash
# 直接赋值 
name="cizel"

# 语句赋值
for file in `ls /etc`
```

### 变量使用

```bash
# 定义变量 name
name="cizel"

# 使用美元 ($) 符号
echo $name

# 使用美元 ($) 符号和括号结合, 常用于字符串拼接
echo ${name}
```

or

```bash
# 高级用法

# 默认值: 如果变量没有声明, 使用默认值 ${var=DEFAULT} 
echo ${name="ok"}   
# output: ok

# 默认值: 如果变量没有声明,或者为空字符串, 使用默认值 ${var:=DEFAULT} 
name=""
echo ${name:="ok"}
# output: ok
```

## Shell 字符串

Shell 的字符串与 PHP 的字符串相同, 分为 `单引号字符串` 和 `双引号字符串`

### 字符串定义

```bash
$name="cizel"
#单引号中变量和符号不会被解析
echo 'my name is ${name}'
# output: my name is ${name}

#双引号中变量和符号会被解析
echo 'my name is ${name}'
# output: my name is $shizhen
```

### 字符串连接

```bash
name="cizel"
echo $name $name 
# output:cizel cizel
```

### 字符串长度

```bash
name="cizel"
echo ${#name}
# output: 5
```

### 字符串截取

```bash
name="my name is cizel"
echo ${name:2:5}
# output: name 
```





## 未完，待续

## 相关链接

- [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh)
- [linux 几种常见的 Shell](https://blog.csdn.net/whatday/article/details/78929247)
- [Shell 脚本编程 30 分钟入门](https://github.com/qinjx/30min_guides/blob/master/shell.md)
