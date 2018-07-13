---
title: "Xcode-select Error"
date: 2018-05-02T07:54:46+08:00
keywords: ["Hugo"]
tags: ["xcode-select", "error", "xcodebuild", "CommandLineTools"]
categories: ["解决方案"]
draft: true
---

安装 electron 项目时候的报错


> xcode-select: error: tool ‘xcodebuild’ requires Xcode, but active developer directory ‘/Library/Developer/CommandLineTools’ is a command line tools instance

解决方案: 

```bash
sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer
```



