---
title: "Memcache 基础使用方法"
date: 2016-08-19    T00:15:03+08:00
lastmod: 2018-05-10T00:15:03+08:00
draft: false
keywords: ["Memcache"]
categories: ["PHP", "笔记"]
---

##  Memcache 介绍

### 什么是 Memcache

Memcache 是一套分布式高速缓存系统，

- 分布式：以在多台操作系统中同时安装 Memcache 服务，可以达到很好的集群效果。
- 高速：Memcache 所有的数据都是维护在内存中的。

<!--more-->

### Memcache 有什么用？

当应用 **访问量** 特别大的时候，数据库的访问量也会特别大。Memcache 的出现，可以在运用和数据库之间增加一个缓冲层。那么之前在数据库中读取过的数据在第二次读取的时候，可以直接去访问 Memcache 去读取这些数据，从而减轻数据库的压力。

### 怎么理解 Memcache？

Memcache 相当于只有一张表的数据库。这张表有二个字段，分别是主键 Key，和数据 Value。Key 用来保证我们查找值得唯一性。


![](https://static.cizel.cn/2018-05-10-15258825827340.jpg)


### Memcache 的使用场景

#### 1. 非持久化存储：对数据存储要求不高
如果数据丢失也不会对系统造成太大的影响。当系统断电或者重启的时候，内存会被清空，之前保存在 Memcache 当中的数据也会被清空。所以只能把 Memcache 当成缓存使用，而不能把它当成真正的数据库使用。

#### 2. 分布式存储：不适合单机使用
如果是单机，直接使用数据库查找数据。Memcache 对于内存的消耗很大。
如果使用 Memcache，推荐装在另外一台机器上，单独作为缓存系统。而不是把数据库和 Memcache 装在一台数据库上

#### 3. key/Value 存储：格式简单，不支持  List ，Array 数据类型

Value 存储的是数据的整个部分，不能再把 Value 中的数据进行拆分。


##  Memcached 安装

Memcached 是一个 C/S 架构的缓存系统，分为服务端的安装和客户端的安装。

### Memcached 服务端的安装

#### 编译安装 Libevent Memcache

如果是编译安装可以指定软件的安装路径，安装过程时间长。


#### 依赖包管理安装 apt-get、 yum

```bash
apt-get install memcached
```
or
```bash
yum install memcached
```

### Memcached 服务端的启动

```bash
/usr/bin/memcached -d -l 127.0.0.1 -p 11211 -m 150 -u root
```

`-d`：进程守护
`-l`：ip地址
`-p`：端口号
`-m`：分配的内存大小
`-u`：启动服务的用户

查看：`ps -ef | grep memcached`

### Memcached 客户端的安装

#### 安装 Libmemcached

采用编译安装的方式

```bash
cd libmemcached-1.0.18
./configure --prefix=/usr/lib/libmemcached
meke && make install
```

#### 为 PHP 安装 memcached 拓展

```bash
cd memcached-2.2.0
phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-libmemcached-dir=/usr/lib/libmemcached --disable-memcached-sasl
make && make install
```

```bash
vim /etc/php/php7.0/php-fpm/php.ini
//添加
extension = memcached.so
```

## PHP 中使用 Memcache

###  常用类

系统类 ：**addServer** , addServers, getStatus, getVersion

数据类：add, **set**, **delete**, flush, replace, increment, **get**

进阶类：setMulti, deleteMulti, get Multi, getResultCode, getResultMessage


####  addServer

```php
public bool Memcached::addServer ( string $host , int $port [, int $weight = 0 ] )
```

`host` memcached服务端主机名。如果主机名无效，相关的数据操作的返回代码将被设置为Memcached::RES_HOST_LOOKUP_FAILURE。

`port` memcached服务端端口号，通常是11211。

`weight` 此服务器相对于服务器池中所有服务器的权重。此参数用来控制服务器在操作时被选种的概率。这个仅用于一致性 分布选项，并且这个值通常是由服务端分配的内存来设置的。

#### set

```php
public bool Memcached::set ( string $key , mixed $value [, int $expiration ] )
```
`key` 用于存储值的键名。

`value` 存储的值。

`expiration` 到期时间，默认为 0。 更多信息请参见到期时间。

#### get

```php
public mixed Memcached::get ( string $key [, callback $cache_cb [, float &$cas_token ]] )
```

`key` 要检索的元素的key。

`cache_cb` 通读缓存回掉函数或NULL.

`cas_token` 检索的元素的CAS标记值。


## 项目中使用 Memcached

###  即时生成缓存

适用用 **新闻详情**   **文章详情** 这情况

### 提前生成缓存

**网站首页** 的情况，定时脚本把缓存生成好

### 永久缓存

适用于 **关于我们** 的情况



