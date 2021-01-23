---
title: "Wireshark 抓包: Chrome https 最佳配置方案"

date: 2019-11-27
lastmod: 2019-11-27

keywords: ["wireshark", "https", "tls", "ssl", "MacOS"]

tags: ["wireshark"]
categories: ["开发者手册"]

draft: false
---

Wireshark 是一个很棒的流量分析软件，如今几乎所有的对外的网站和域名都加上了 HTTPS，抓包的数据无法直接解析。

本文主要介绍怎么配置 Wireshark，以及 Chrome 浏览器来实现解析 HTTPS 的流量。

<!--more-->

## 配置方式

### Chrome 启动设置

Chrome 启动参数需要配置如下内容：

- --user-data-dir 配置用户使用数据
- --ssl-key-log-file 配置 ssl-key-log 的存储路径

```bash
$ /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=/tmp/chrome --ssl-key-log-file=/tmp/.ssl-key.log
```

**启动结果如下：**

> 执行命令后，会启动一个全新的 Chrome

![](https://static.cizel.cn/2019-11-27-15748490692512.jpg)


### Wireshark 设置

![](https://static.cizel.cn/2019-11-27-15748488327759.jpg)

## 结果展示

**正常解密 HTTPS 流量**

![](https://static.cizel.cn/2019-11-27-15748498342338.jpg)

**正常 Follow HTTP Stream**

![](https://static.cizel.cn/2019-11-27-15748500223129.jpg)

## 异常情况

**出现 Opening in existing browser session.**

解决方式：关闭掉用命令启动的 Chrome，然后重新运行 Chrome 启动命令

```bash
$ ps -ef | grep /tmp/.ssl | awk 'NR==1{print $2}' | xargs  kill -9
$ /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --user-data-dir=/tmp/chrome --ssl-key-log-file=/tmp/.ssl-key.log
```

## 参考

- [Decrypting TLS Browser Traffic With Wireshark – The Easy Way!](https://redflagsecurity.net/2019/03/10/decrypting-tls-wireshark/)
- [Wireshark 2 is the simplest way to inspect HTTPS on your Mac](https://certsimple.com/blog/ssl-wireshark-mac-osx)


