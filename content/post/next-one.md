---
title: "NextOne 安全勇士30强诞生赛 Writeup"

date: 2016-07-08T23:49:15+08:00
lastmod: 2018-11-21T23:47:03+08:00


keywords: ["CTF", "安全"]

tags: ["CTF", "安全"]
categories: ["网络安全"]

draft: false
---

Cizel在几天前，参加了i春秋，腾讯实习30强挑战赛，得到了26名的成绩，总分1721分。PWN的 writeup 和逆向的 writeup 没有。

<!--more-->

## 基础题

### 能看到吗？

- 隐藏在其中

截图：
![Alt text](http://static.cizel.cn/nextone/1.png)

打开网站，右击查看源码

```javascript
<script type="text/javascript">
function getValue()
{
alert("flag{a2714506-b3e2-417d-bac9-e8d078ed4d96}")
}
</script>
```

题目的本意是点击图片，弹出 Flag 来着。


### 加密的地址

 - 看着有点特殊？

截图：

![Alt text](http://static.cizel.cn/nextone/2.png)

打开网站，网站不能右击，使用F12查看源码

```
<!--flag{455ec542-5f3e-4cd6-beb0-26a5e67338fe}-->
```

Flag就在源码之中。


### 看仔细了

 - 能找出它来吗？

截图：
![Alt text](http://static.cizel.cn/nextone/3.png)

右击查看源代码

```javascript
<script>
	function time(){
	pass='MWMzNmNkNTI=';
	pass1='NDFiNzczNWVlZmRj';
	}
<!--时空晶石的能量几乎被"消耗殆尽"-->
</script>
```

这不就是2个输入框的密码嘛，输入尝试了一下，木有提示。

那就Base64解密试试：

```
pass = 1c36cd52
pass1 = 41b7735eefdc
```

输入之后，弹出Flag


### 外表可是具有欺骗性

 - 你确定能过去？

截图：
![Alt text](http://static.cizel.cn/nextone/4.png)

老规矩，右击查看源代码

```javascript
&#102;&#108;&#97;&#103;&#123;&#53;&#50;&#98;&#97;&#98;&#50;&#53;&#56;&#45;&#97;&#49;&#97;&#54;&#45;&#52;&#54;&#99;&#51;&#45;&#98;&#54;&#50;&#49;&#45;&#102;&#54;&#101;&#50;&#53;&#49;&#52;&#56;&#52;&#97;&#49;&#102;&#125;
```

看到了上面的一段，10进制的编码。先转16进制试试，转换之后直接是Flag


### 洞察力是你取胜的关键

 - 洞察力是你取胜的关键

截图：
![Alt text](http://static.cizel.cn/nextone/5.png)

这个题目大标题和小标题，一样耶。

同上，右击查看源代码

```javascript
<script src="./js/5.js" type="text/javascript"></script>
```
通过分析，只有这个JS有问题,JS的内容如下：
```javascript
eval(function(p,a,c,k,e,r){e=function(c){return c.toString(a)};if(!''.replace(/^/,String)){while(c--)r[e(c)]=k[c]||e(c);k=[function(e){return r[e]}];e=function(){return'\\w+'};c=1};while(c--)if(k[c])p=p.replace(new RegExp('\\b'+e(c)+'\\b','g'),k[c]);return p}('c d(){a("6:2:3:4:0:3:4:1:e:5:b:1:2:0:5:1:0:2:7:7:0:8:5:9:0:f:4:9:8:3:6:0")}',16,16,'61|38|64|39|30|63|32|65|34|33|eval|62|function|aaa|31|66'.split('|'),0,{}))
```

JS解密之后：

```javascript
function aaa() {
    eval("32:64:39:30:61:39:30:38:31:63:62:38:64:61:63:38:61:64:65:65:61:34:63:33:61:66:30:33:34:39:32:61")
}
```

把这些10进制的数字转换为16进制：

`2d90a9081cb8dac8adeea4c3af03492a`

32位，联想到了md5，解密后得到 `zf651q`

输入对话框，得到Flag


基础篇结束。

## 算法基础

强烈推荐使用Python


### 神奇数

- 有多个数字的平方的值出现了0至9的数字，而且只出现一次，从小到大，你能得到第一次出现的值吗？

截图：
![Alt text](http://static.cizel.cn/nextone/2_2.png)

思路分析：先锁定平方可以得到10位数的数字的范围，然后把这些数字的每一位加入Set之中，去除重复的元素。如果没有重复即set的长度为10，输入。

Python 代码：

```python
#!/usr/bin/python
# -*- coding=utf-8 -*-

import math

min = int(math.sqrt(10**9))
max = int(math.sqrt(10**10))

print min,max

for i in range(min,max):
    mySet = set()
    for j in str(i*i):
        mySet.add(j)
    if len(mySet)==10:
        print i
        break
```

output: 32043

输入数字，顺利得到Flag

### 统计

- 小明的数学作业，你能帮他完成这道题吗？

截图：

![Alt text](http://static.cizel.cn/nextone/2_1.png)

这个题目的端口号是：6666 被Chrome屏蔽，我当时还以为是题目链接坏了，还找了管理员来着。

Python代码：

```python
#!/usr/bin/python
# -*- coding=utf-8 -*-

sum = 1+100
for i in range(2,100,2):
    sum +=i*(i+1)

print sum
```

output：164251

输入数字，顺利得到Flag

###  找到它！
- 找xx位字母或数字，取出来的值组成flag

截图：

![Alt text](http://static.cizel.cn/nextone/2_3.png)

这题没啥好说的，直接上Python代码：

```python
#!/usr/bin/python
# -*- coding=utf-8 -*-

str = "ud1SI80j4CJWDLImOTHoTS9lYPHG009MoD5Ji...."

print str[101],str[399],str[1200],str[1603],str[1799]

```

output ：9 V e v F

输入对话框得到Flag

算法篇结束

## 计算机原理

### 你会吗？

- 题目 ：一般将多个中断触发器组合为中断寄存器，而整个中断寄存器的内容称为______。

答案：中断字

### 算算二进制

 - 题目：20位二进制无符号整数的数值范围是0到_______。

Python代码：

```python
#!/usr/bin/python
# -*- coding=utf-8 -*-
print 2**20-1
```

答案：1048575

### ASCII与二进制

- ASCII码中表示一个字符需要几位二进制码?
答案： 7

计算机原理完

## 加密解密

### 就差一步
-  题目："synt{91o19r02-4so7-45o6-n59o-4rqnp2o1q2nq}"这段字符代表着什么(听说与13有关)？

因为和13有关，所以就是字符的Ascii 加13或者减13，显然只能是减13

`flagn,$b$,e#% 'fb* '(b) a(,b 'edac%b$d%adp`

全部都减好像不对，试试只减字母试试，成功拿到Flag

Python代码：

```python
#!/usr/bin/python
# -*- coding=utf-8 -*-

str1 = 'synt{91o19r02-4so7-45o6-n59o-4rqnp2o1q2nq}'
output =''
for i in str1:
    if i>'a' and i< 'z':
        output+= chr(ord(i)-13)
    else:
        output+=i

print output
```

### 错误的md5

- 题目：小明修改这段字符，不小心弄错了，能还原出正确的吗？ 4d1e3cbl10c094e4f7c704232956bc34

给出的MD5是32位了，当时做这个题没什么思路，就一直在网上搜索MD5的格式，看着看着发现了32位MD5和16位MD5的关系。

![Alt text](http://static.cizel.cn/nextone/md5.jpg)


然后是试了一下中间的16位的md5，查询结果：`企鹅`

输入企鹅就是得到Flag

### 残缺的base64

- 题目：这个编码缺失一个字符，你能还原它吗？ 6ZWc6Iqx5_C05pyI

先遍历一波，

```python
#!/usr/bin/python
# -*- coding=utf-8 -*-
import base64

for i in range(1,256):
    str1 = '6ZWc6Iqx5'+chr(i)+'C05pyI='
    print str1
    print base64.decodestring(str1)
```

查找出没有乱码可能的：
```python
6ZWc6Iqx5IC05pyI=
镜花?月
6ZWc6Iqx5JC05pyI=
镜花?月
6ZWc6Iqx5KC05pyI=
镜花?月
6ZWc6Iqx5LC05pyI=
镜花?月
6ZWc6Iqx5YC05pyI=
镜花倴月
6ZWc6Iqx5ZC05pyI=
镜花吴月
6ZWc6Iqx5aC05pyI=
镜花場月
6ZWc6Iqx5bC05pyI=
镜花尴月
6ZWc6Iqx5oC05pyI=
镜花怴月
6ZWc6Iqx5pC05pyI=
镜花搴月
6ZWc6Iqx5qC05pyI=
镜花栴月
6ZWc6Iqx5rC05pyI=
镜花水月
```
输入测试，为`镜花水月`，得到Flag

### 这句话有点意思！

截图：
![Alt text](http://static.cizel.cn/nextone/4_3.png)

以前看到过类似的题目，是培根密码（5个字母一组）

我*年*轻时*注*意到，*我*每做十*件事*有九件*不成*功，于是我就十倍*地*去努力干下去。—— 萧*伯纳*

转换为AB：ABAAB AABAA ABBAA ABBAA AAAAA BAAAA AAABB

`JEMMAQD` 或者 `kennard`

输入kennard正确.

加密解密完.

## 流量分析

### 有选择吗？

- 题目：捕获文件中的TCP只包含有HTTP，但是HTTP在TCP中的百分比却只有12.76%，那么余下的百分比是。A.隐藏协议的数据包              B.数据传输和控制的数据包
C.程序漏洞引起的计算错误    D.没有正确答案

打开16关.pcap文件，

![Alt text](http://static.cizel.cn/nextone/5_1.png)

以这一段为例子，
- 如果：A发到B连续几个包，seq号不变，ack号一直在变大，说明A一直在收B的数据，一直在给B应答（和本题目一样）
- 如果：A发到B连续几个包，seq号一直变大，ack号一直没变，说明A一直在向B发数据，不用给B应答，而是在等B的应答

所以答案是：B

### flag呢

- 题目：flag在哪呢？下载看看吧！

打开 17.pcapng
![Alt text](http://static.cizel.cn/nextone/5_2.png)

是几段简单的Post请求，查看内容，是Boss 和 test在聊天 (gbk2312编码)
工具地址：http://tool.chinaz.com/tools/urlencode.aspx

	Boss：去做个ctf
	test：要什么题
	Boss：自己想
	test：有什么要求吗
	Boss：flag{你自己看着办}

得到Flag

### 万中有一

- 题目：下载查看这个文件，数据中有你想要的。

打开 18.pcapng，过滤出HTTP的请求

![Alt text](http://static.cizel.cn/nextone/5_4.png)

打开网站一看

![Alt text](http://static.cizel.cn/nextone/5_3.png)

是一个联系网站注入的界面，读取这些post的请求就可以看出，一次一次的注入测试。

	uname=as&passwd=asss&submit=Submit

	uname=as%22%29%20UNION%20ALL%20SELECT%20CONCAT%280x7176766a71%2CIFNULL%28CAST%28DATABASE%28%29%20AS%20CHAR%29%2C0x20%29%2C0x716a626a71%29%2CNULL%23&passwd=asss&submit=Submit

	uname=as%22%29%20UNION%20ALL%20SELECT%20%28SELECT%20CONCAT%280x7176766a71%2CIFNULL%28CAST%28%60user%60%20AS%20CHAR%29%2C0x20%29%2C0x6b736c707066%2CIFNULL%28CAST%28pass%20AS%20CHAR%29%2C0x20%29%2C0x716a626a71%29%20FROM%20Less_6.admin%20LIMIT%200%2C1%29%2CNULL%23&passwd=asss&submit=Submit

最后一次注入成功拿到Flag

	SELECT congratulation, ticket FROM successful WHERE congratulation=("as") UNION ALL SELECT (SELECT CONCAT(0x7176766a71,IFNULL(CAST(`user` AS CHAR),0x20),0x6b736c707066,IFNULL(CAST(pass AS CHAR),0x20),0x716a626a71) FROM Less_6.admin LIMIT 0,1),NULL#") and ticket=("asss") LIMIT 0,1
	qvvjqadminkslppfflag{6c0d68b0-c638-4fb5-a8f5-fdc756daf7e0}qjbjq

### 大黑阔

打开 19.pcapng，过滤出POST的请求 http.request.method==POST

当 POST /webchat/chat/sendmes.php HTTP/1.1

发现是2个人在对话，内容如下：

	i am here what?
	i don't have idea
	i don not have idea
	......
	but i was born in tangshan
	sounds like not bad
	where is that?
	if it is a place with water....
	i can not swim
	i have no idea
	what meaning?
	what is 100?
	yes....
	but i really do not know the way
	**canyou show me the way in the map?**
	ok
	see that?
	en..

重点在哪个Map图片上面 POST /upfile/upload_file.php HTTP/1.1

图片是JPG格式的，按照JPG格式进行解析,得到一个中国地图的图片，放大

![Alt text](http://static.cizel.cn/nextone/5_6.png)

flag 在这里，内容：flag{@GOOD_L4ck_H3r3@}  good luck here 的意思，这次写

writeup光线太亮，完全看不到啊（PS:感觉这道题的难道就是看图片）

流量分析完

## 逆向破解
我当时下载的比较早，Reverse1 Reverse4都是直接提供Flag在附件中，所以也就没有分析，如图，重点分析Reverse3

![Alt text](http://static.cizel.cn/nextone/12.png)

### Reverse3
截图：
![Alt text](http://static.cizel.cn/nextone/6_1.png)

典型的寻找 Password，丢入Android Killer中分析,关键代码如下：

```java
public class MainActivity
  extends Activity
{
  public void GetKey(View paramView)
  {
    paramView = ((EditText)findViewById(2131230721)).getText().toString();
    if (!TextUtils.isEmpty(paramView.trim()))
    {
      char[] arrayOfChar1 = getResources().getString(2131034115).toCharArray();
      int j = arrayOfChar1.length;
      char[] arrayOfChar2 = new char[1024];
      try
      {
        new InputStreamReader(getResources().getAssets().open("src.jpg")).read(arrayOfChar2);
        i = 0;
        if (i >= j)
        {
          if (!paramView.equals(new String(arrayOfChar1))) {
            break label175;
          }
          Toast.makeText(this, "恭喜您，输入正确！Flag==flag{Key}", 1).show();
        }
      }
      catch (Exception localException)
      {
        int i;
        for (;;)
        {
          localException.printStackTrace();
        }
        int k = arrayOfChar2[arrayOfChar1[i]] % '\n';
        if (i % 2 == 1) {
          arrayOfChar1[i] = ((char)(arrayOfChar1[i] + k));
        }
        for (;;)
        {
          i += 1;
          break;
          arrayOfChar1[i] = ((char)(arrayOfChar1[i] - k));
        }
        label175:
        Toast.makeText(this, "not right! lol......", 1).show();
        return;
      }
    }
    Toast.makeText(this, "请输入key值！", 1).show();
  }
```

大概的意思就是：打开一张`src.jpg`作为字典和输入的内容`Tr43Fla92Ch4n93`进行运算，运算的规则是：

```java
if (i % 2 == 1) {
    arrayOfChar1[i] = ((char)(arrayOfChar1[i] + k));
 }else{
    arrayOfChar1[i] = ((char)(arrayOfChar1[i] - k));
}
```

通过读取上面的代码，自己翻译出来如下：

```java
public class MainActivity extends AppCompatActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        char[] arrayOfChar1 = "Tr43Fla92Ch4n93".toCharArray();//这个是string.xml中
        int j = arrayOfChar1.length;
        char[] arrayOfChar2 = new char[1024];

        try {
            new InputStreamReader(getResources().getAssets().open("src.jpg")).read(arrayOfChar2);
            int k=0;
            for(int i=0;i<j;i++){
                k = arrayOfChar2[arrayOfChar1[i]] % '\n';
                if (i % 2 == 1) {
                    arrayOfChar1[i] = ((char) (arrayOfChar1[i] + k));
                }else{
                    arrayOfChar1[i] = ((char) (arrayOfChar1[i] - k));
                }
            }
            Log.i("log",new String(arrayOfChar1));
        } catch (Exception localException) {

        }
    }
}
```

通过日志输入的方式，拿到正确的key.

## 漏洞利用

还没学缓冲区溢出，所以就没有来得及做

## Web安全

### 执行!
- 题目：没有漏洞?

截图：
![Alt text](http://static.cizel.cn/nextone/8_1.png)

看到这个题目的第一反应是，图片隐写。但是提供各种方式的查找，可以判断这不是一个隐写它。

换一个思路：a gift for you,can you find it. 难道是直接给了gift这个文件。

输入 ./gift  然后 not found。

于是我又试了一下 ./gift.txt 还是not found

运气不好，使用burpsuit 进行攻击：

![Alt text](http://static.cizel.cn/nextone/8_2.png)

找到了这个gift文件gift.rar 下载，得到Flag

### 登录
 - 题目：不仅仅是登录
![Alt text](http://static.cizel.cn/nextone/8_3.png)

提示为：Unable to connect to the database1: Less_6

说明不是一个注入题目，提示了数据库无法连接，可能存在 数据库文件,使用burp尝试	`Less_6.sql` 失败，使用brup进行`*.sql `攻击

![Alt text](http://static.cizel.cn/nextone/8_4.png)

找到了一个sql.sql的文件，打开

```php
-- MySQL dump 10.13  Distrib 5.1.73, for redhat-linux-gnu (x86_64)
--
-- Host: localhost    Database: Less_6
-- ------------------------------------------------------
-- Server version	5.1.73

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `admin`
--

DROP TABLE IF EXISTS `admin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `admin` (
  `user` char(10) DEFAULT NULL,
  `pass` char(100) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `admin`
--

LOCK TABLES `admin` WRITE;
/*!40000 ALTER TABLE `admin` DISABLE KEYS */;
INSERT INTO `admin` VALUES ('admin','flag{44f49248-d10e-40c0-976a-3b45b184f04e}');
/*!40000 ALTER TABLE `admin` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-04-06 20:16:22
```

Flag 就在其中.

### flag在哪里?

- 题目：当你上传成功的时候就会得到flag。

截图：
![Alt text](http://static.cizel.cn/nextone/8_5.png)

典型的文件上传类型，先上传一个文件试试，修改文件名
![Alt text](http://static.cizel.cn/nextone/8_6.png)
提示：`件类型不对或者文件大小过大！请重新上传！！`

然后用Python写字典跑了所有的文件的Content-Type 发现了 image/jpeg 有不同的提示：`不会吧！上传图片文件不好吧！至少你也传个能解析的啊！Come baby`

感觉有戏，再一次修改文件名（因为是php的网站，websell肯定是php没错）

提示：`文件上传出错` 这次不一样了,有戏

修改成大写试试：
![Alt text](http://static.cizel.cn/nextone/8_7.png)

然后Flag就出来了

![Alt text](http://static.cizel.cn/nextone/8_8.png)

### 执行!
- 题目： 据说执行命令就能看到flag？

右击查看源码：

```
<!--
本系统测试账户：账号user 密码user,
如需上线使用，请删除默认账户！！！
为了保证功能正常使用，请使用谷歌或者火狐浏览器打开。
-->

```
登录试试看

![Alt text](http://static.cizel.cn/nextone/8_9.png)

一个shell窗口,ls 一下看到有flag的文件夹，但是没有cd命令。

用burpsuit进行攻击扫描，无果

一想，要是可以拿到管理员权限，说不定就有更多的命令了。

可能登陆可以注入，注入试试

![Alt text](http://static.cizel.cn/nextone/8_10.png)

成功登陆

![Alt text](http://static.cizel.cn/nextone/8_11.png)

成功拿到flag

Web安全完

## 渗透测试

### 弹弹弹
- 题目：flag是弹出来的

看完题目第一反应是XSS， 输入`<script>alert('xss')</script> `

弹出Flag

### 就在其中

- 题目：文件是可以被“调用”的。

![Alt text](http://static.cizel.cn/nextone/9_1.png)

BurpSuit 攻击走起

![Alt text](http://static.cizel.cn/nextone/9_2.png)

文件为 1234.php 里面为空，说明Flag可能就是这个文件里面，而且题目提示是文件包含。
`?file=../../../../../../../../../etc/passwd`
输出：

```
root:x:0:0:root:/root:/bin/bash bin:x:1:1:bin:/bin:/sbin/nologin daemon:x:2:2:daemon:/sbin:/sbin/nologin adm:x:3:4:adm:/var/adm:/sbin/nologin lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin sync:x:5:0:sync:/sbin:/bin/sync shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown halt:x:7:0:halt:/sbin:/sbin/halt mail:x:8:12:mail:/var/spool/mail:/sbin/nologin uucp:x:10:14:uucp:/var/spool/uucp:/sbin/nologin operator:x:11:0:operator:/root:/sbin/nologin games:x:12:100:games:/usr/games:/sbin/nologin gopher:x:13:30:gopher:/var/gopher:/sbin/nologin ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin nobody:x:99:99:Nobody:/:/sbin/nologin vcsa:x:69:69:virtual console memory owner:/dev:/sbin/nologin sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin apache:x:48:48:Apache:/var/www:/sbin/nologin
```
看到乌云的这一篇 [http://drops.wooyun.org/tips/3827](http://drops.wooyun.org/tips/3827)

利用php流filter：`?file=php://filter/read=convert.base64-encode/resource=1234.php`

使用读取文件base64的方式,得到

`PD9waHAgDQovL2ZsYWd7M2I0NTZlMDAtOTU0Yi00MjkwLTkyZWItOTY2ZTM4NzUwNDc3fTs/Pg`
解密：
```
<?php
//flag{3b456e00-954b-4290-92eb-966e38750477};?>
```
得到 Flag


### 瞒天过海

- 可以欺骗所有人! （感觉被欺骗）

截图：

![Alt text](http://static.cizel.cn/nextone/9_3.png)

登录成功返回了一个token

![Alt text](http://static.cizel.cn/nextone/1467716201271.png)

32位，试着md5解密为：`test2`

构造token的题目，尝试`admin2`失败

想了一下 test2 是不是ID为2的用户为test

那么ID为1的用户那肯定是admin，那就是`admin1`,md5加密修改token

成功拿到Flag

### 摄影师的家

- 摄影师的服务器上放了一份特殊的文件，需要你取出来？

网站又挂了，网站为：`秋潮视觉工作室`系统。 存在Sql注入

注入点有很多，使用sqlmap随便跑一个注入点.

可以知道有一个admin的表, 有3个字段

`admin` `id` `passwod`

获取账号和密码，账号为linhai，密码经过md5解密：linhai19760812

在后台，找到一个上传文件的位置，可以上传图片。

上传一张图片`1.jpg`到Upload 里面。

使用网站的备份功能修改为 `1.asp`

用菜刀链接一句话木马。

连接成功，拿到WebShell.

经过观察，找到Flag文件在C盘的根目录下，一个为Flag.txt的文件，下载后获取flag

渗透测试完

以上












































