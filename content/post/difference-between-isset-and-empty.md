---
title: "Isset 与 Empty 的区别对比"
date: 2017-01-13T00:23:38+08:00
lastmod: 2018-05-10T00:23:38+08:00
draft: true
keywords: []
categories: ["PHP"]
---

##  isset 与 empty 的区别

###   isset

```
bool isset ( mixed $var [, mixed $... ] )
```

###  empty

```
bool empty ( mixed $var )
```

<!--more-->

#### 关系：

```
empty() 等效于  !isset($var) || $var == false
```


#### 什么情况会被判定 isset 的False

- 变量未设置默认为null

- 变量的值为null

- unset 的变量会被变成null


#### 什么时候会被判定未 False

- "" (空字符串)
- 0 (作为整数的0)
- 0.0 (作为浮点数的0)
- "0" (作为字符串的0)
- NULL
- FALSE
- array() (一个空数组)
- $var; (一个声明了，但是没有值的变量)


**当以上情况出现一个的时候，empty 就为 True**

