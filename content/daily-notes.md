---
title: "日常记录 - Flag"
date: 2018-05-16T23:46:44+08:00
lastmod: 2018-05-24T23:46:44+08:00
draft: false
keywords: ['Spacemacs', 'Spacevim']
categories: ["观点与感想"]
---

## 日常立 Flag

- [x] 写 Shell 脚本编程的使用文档 （开始时间：2018-05-18, 完成时间: 2018-05-27)
- [ ] Vim 每日学习新操作, 一个月打卡 (创建时间: 未知, 完成时间:未知) 

---

## 2018-05-27

Shell 脚本编程进度 `40%` to `100%`, 

## 2018-05-26

Shell 脚本进度更新 `35%` to `40%`

因为现在的评论系统 Disqus 在国内无法访问, 后面打算使用 `Gitalk` + 自动初始化的方式. 

## 2018-05-25

公司组织户外素质拓展，第一次参加这样的活动，挺累的也很有收获。

## 2018-05-24

Shell 脚本编程进度更新 `30%` to `35%`.

理解了 Nginx 的 Location 功能，可以在不同的 `Location /api` 运行一个新的服务。

## 2018-05-23

在 Go 语言的 Web 框架 Gin 上使用，JWT(Json Web Token) 的中间件，实践使用 JWT 的鉴权方式。

## 2018-05-22

GitHub 添加 GPG Key (Signing commits using GPG), 避免传输过程中信息被篡改。提交代码使用：`git commit -S -m your commit`

Shell 脚本编程进度 `20%` -> `30%`.

## 2018-05-21

今天工作的时候大部分时间都在写 Shell, 学习使用 `jq` 命令去操作 Json 文件，学习 `sed` 命令去替换文》件的内容。`sed` 还有很多功能，后面慢慢的学习。

## 2018-05-20

今天写了一部分 Shell 编程的文档，写了 Shell 变量的一部分。

重新学习一遍 [中文文案排版指北](https://github.com/sparanoid/chinese-copywriting-guidelines), [中文技术文档的写作规范](https://github.com/ruanyf/document-style-guide), 并在后面的文章中实践规范。

## 2018-05-19

今天看了阿里的 Java 代码规范，和 PHP PSR1, PSR2 大部分保持一致，但是还是有很多 `强制`, `推荐` 的部分比较容易在项目中执行。

今天整理了自己的印象笔记，将之前收集的一些 Inbox （收件箱） 的内容。阅读到了一片关于 Linux Shell 的文章放入了重点项目中。『坏笑』

## 2018-05-18

今天有 2 个新认知 `HttpDNS`, `ProtoBuf`, 开始立 Flag. 加油吧~

新认知：`HttpDNS` 基于 HTTP 协议向 DNS 服务器发送域名解析请求，替代传统的 DNS 协议向运营商 Local DNS 发起解析请求的传统方式。可以避免域名劫持和跨网访问的问题。主要运用于移动应用的场景，改善域名解析和劫持问题。

新认知：`ProtoBuf` (Protocol Buffers) 是一种轻便高效的结构化数据存储格式。可以用于结构化数据串行话，或者说序列号。比 JSon, XML 数据量更小。适合用于 PRC 数据交互或者数据存储。可以用于通讯协议，数据存储等领域的语言无关，平台无关，可拓展的序列化结构数据格式。




## 2018-05-17

最近由折腾 Spacemacs 到 Spacevim, 这些软件真的很强大，比如 emacs 中的 major-mode, minor-mode, major-mode 只有负责语言层面的代码高亮，语法检查，代码缩减等等；而 minor-mode 负责公用的部分，比较代码补全显示行号等。这样的思想真的大开眼界。

其次是快捷键的设计思想，比如 `SPC b` 为 buffer 相关的操作，`SPC f` 为文件相关的操作，`SPC h` 为帮助相关的操作，`SPC x` 为执行相关的操作，可以简化对快捷键的记忆。但是操作量比较大，基本一个命令得 `SPC` + 2-3 个字母。

折腾结束，Spacemacs 很强大，但是感觉到卡顿的情况，也没有原生的 vim 的体验好。Spacevim 也很强大，但是一味的模仿 Spacevim 使得快捷键过于繁琐，相关的插件可以在 dotfile 中添加。

## 2018-05-16

最近比较焦虑，研究 SpaceVim 不小心误删了 vim 的配置，很是沮丧。通过在网上的查找，找到了 Time Machine 时间机器可以回滚某个文件，试用后心情愉快了很多。以后得多多备份才好。
