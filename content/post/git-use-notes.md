---
title: "Git的使用笔记"
date: 2016-07-10T00:00:38+08:00
lastmod: 2018-05-10T00:00:38+08:00
draft: true
keywords: ["git"]
categories: ["剪贴板", "观点与感想"]
---

最近在进行一个华为校园APP开发者大赛，三个小组成员，第一次正在的使用 Git 来团队协作开发，其中遇到了很多问题，故重新学习了一遍 Git

<!--more-->

### 使用前

1. 安装git
2. 配置name 和 email
```bash
git config --global user.name "Your Name"
git config --global user.email "email@example.com"
```

### 使用中

#### 本地单用户工作流

![本地单用户工作流](http://static.cizel.cn/uploads/2016/07/1.JPG)

1. 初始 Git 管理仓库
] 
```bash
git init
```

2. 添加文件到 Git 仓库

```bash
git add readme.txt
```

3. 提交文件到 Git 仓库

```bash
git commit -m "upload readme file"
```

#### 远程单用户工作流

![远程单用户工作流](http://static.cizel.cn/uploads/2016/07/2.JPG)

1. 克隆一个远端 Git 版本库 or 关联本地版本库

```bash
git clone https://github.com/cizel/soft_backup
```

```bash
git remote add origin git@github.com:cizel/soft_backup.git
```
2. 添加文件到 Git 仓库

```bash
git add readme.txt
```
3. 提交文件到 Git 仓库

```bash
git commit -m "upload readme file"
```

4. 上传到远端 Git 仓库

```bash
git push origin master
```

#### 多用户分支使用策略

1. 基本语法

	查看分支：`git branch`
	
	创建分支：`git branch <name>`
	
	切换分支：`git checkout <name>`
	
	创建+切换分支：`git checkout -b <name>`
	
	合并某分支到当前分支：`git merge <name>`
	
	删除分支：`git branch -d <name>`
	
2. 分支的使用

![Alt text](http://static.cizel.cn/uploads/2016/07/3.JPG)

Git 创建 Develop 分支的命令：

```bash
git checkout -b develop master
```

将 Develop 分支发布到 Master 分支的命令

```bash
　　# 切换到Master分支
　　git checkout master
　　# 对Develop分支进行合并
　　git merge --no-ff develop
```

`tip:`  `--no-ff`

未使用 `--no-ff` 使用快速合并的策略

![Alt text](http://static.cizel.cn/uploads/2016/07/bg2012070505.png)

使用 `--no-ff` 会执行正常合并，在Master分支上生成一个新节点。为了保证版本演进的清晰，我们希望采用这种做法。
- 
![Alt text](http://static.cizel.cn/uploads/2016/07/bg2012070506.png)

3.  分支的管理策略

一、主分支 Master
首先，代码库应该有一个、且仅有一个主分支。所有提供给用户使用的正式版本，都在这个主分支上发布。

![Alt text](http://static.cizel.cn/uploads/2016/07/bg2012070503.png)
	

二、开发分支 Develop
主分支只用来分布重大版本，日常开发应该在另一条分支上完成。我们把开发用的分支，叫做Develop。

![Alt text](http://static.cizel.cn/uploads/2016/07/bg2012070504.png)


三、 功能分支
第一种是功能分支，它是为了开发某种特定功能，从 Develop 分支上面分出来的。开发完成后，要再并入 Develop。

![Alt text](http://static.cizel.cn/uploads/2016/07/bg2012070507.png)
四、预发布分支
预发布分支是从 Develop 分支上面分出来的，预发布结束以后，必须合并进 Develop 和 Master 分支。它的命名，可以采用release-*的形式。

五、修补bug分支
修补 bug 分支是从 Master 分支上面分出来的。修补结束以后，再合并进 Master 和 Develop 分支。它的命名，可以采用fixbug-*的形式。

![Alt text](http://static.cizel.cn/uploads/2016/07/bg2012070508.png)

### 遇到问题

#### 参看与对比

```bash
# 告诉你有文件被修改过
git status
#可以查看修改内容
git diff
```

#### 版本前进与后退

```bash
# 查看提交历史，以便确定要回退到哪个版本
git log
# 查看命令历史，以便确定要回到未来的哪个版本
git reflog
```

修改版本

```bash
git reset --hard commit_id
```

#### 撤销commit

```bash
git reset --hard commit_id
# 如果使用远端，git push 的情况
git push origin HEAD --force
```

### git revert 和 git reset 的区别

1. git revert 是用一次新的 commit 来回滚之前的 commit，git reset 是直接删除指定的 commit。
2. 在回滚这一操作上看，效果差不多。但是在日后继续merge以前的老版本时有区别。因为 git revert 是用一次逆向的 commit 「中和」之前的提交，因此日后合并老的 branch 时，导致这部分改变不会再次出现，但是 git reset 是之间把某些 commit 在某个 branch 上删除，因而和老的 branch 再次 merge 时，这些被回滚的commit 应该还会被引入。
3. git reset 是把 HEAD 向后移动了一下，而 git revert 是 HEAD 继续前进，只是新的 commit 的内容和要 revert 的内容正好相反，能够抵消要被 revert 的内容。

### git fetch 和 git pull 的区别
1. git fetch：相当于是从远程获取最新版本到本地，不会自动merge
2. git pull：相当于是从远程获取最新版本并merge到本地，git pull相当于git fetch + git merge
 



### 参考文章

[阮一峰 - Git分支管理策略](http://www.ruanyifeng.com/blog/2012/07/git.html)

[廖雪峰 - Git 教程](http://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000)

[Git中pull对比fetch和merge](http://www.zhanglian2010.cn/2014/07/git-pull-vs-fetch-and-merge/)

以上


