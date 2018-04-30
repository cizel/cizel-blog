---
title: "PHP 手册阅读笔记 - 语言参考篇"
date: 2018-04-21T10:07:44+08:00
---

最近计划把 PHP手册，认真的先过一遍。记录一些以前不知道，不明确的知识。

## 语言参考 > 类型

【新认知】强制转换类型用 `settype( mixed $var, string $type )`。判断变量的类型用`is_type `函数。例如： 

```php
if (is_int($an_int)) {
    $an_int += 4;
}
if (is_string($a_bool)) {
    echo "String: $a_bool";
}
```
**判断变量**

```php
is_array( mixed $var )
is_bool( mixed $var )
is_float( mixed $var )
is_integer( mixed $var )
is_null( mixed $var )
is_numeric( mixed $var ) //检测变量是否为数字或数字字符串
is_object( mixed $var )
is_resource( mixed $var )
is_scalar( mixed $var ) //检测变量是否是一个标量  integer、float、string 或 boolean
is_string( mixed $var )
```
**判断函数和方法**

```php
function_exists( string $function_name )
method_exists( mixed $object, string $method_name ) // 判断类的方法
```

### Boolean 布尔类型

【遇到坑】`(string) '0.00'` 被认为是 True，且不为空

```php
$str = '0.00';
$ret = !empty($str):$str:'5.00';
//output:0.00
```
【遇到坑】当字符串 与 数字比较时，会被转换为数字之后进行比较

```php
//将all转换为数字时候为0
var_dump(0 == 'all'); // TRUE, take care
```

### Integer 整型
【新认知】整型的最大值可以用常量 `PHP_INT_MAX` 表示

【新认知】PHP 没有像 C++ /  JAVA 的整除运算，类似 `1 / 2 `，PHP 返回 float 0.5

【旧回顾】转换为整型可以用(int) 或者 (integer) 强制转换。或者通过函数 `intval()` 来转换。

### Float 浮点型

【新认知】比较浮点数的方法

```php
<?php
$a = 1.23456789
$b = 1.23456780
$epsilon = 0.00001
if (abs($a - $b) < $epsilon) {
	echo 'true';
}
```

### String 字符串 
【新认知】使用函数 `ord()` 和 `chr()` 实现 ASCII 码和字符间的转换（PS:这点和 Python 是一样的）
【新认知】 PHP 中没有单独的“byte”类型，已经用字符串来代替了。

### Array 数组
【新认知】 `unset()`函数允许删除数组中的某个键，但是数组的键不会重新索引。可以使用 `array_values()` 函数重新索引。
【遇到坑】避免数组 `$foo[bar]` 的写法，使用 `$foo['bar']`
【新认知】如果一个object类型转换为 array，则结果为一个数组，其单元为该对象的属性。键名将为成员变量名，不过有几点例外：整数属性不可访问；私有变量前会加上类名作前缀；保护变量前会加上一个` '*' `做前缀。这些前缀的前后都各有一个 NULL 字符。

```php
<?php

class A {
    private $A; // This will become '\0A\0A'
}

class B extends A {
    private $A; // This will become '\0B\0A'
    public $AA; // This will become 'AA'
}

var_dump((array) new B());
?>
```

【新认知】 在循环中改变单元，可以用个引用传递来做到

```php
// PHP 5
foreach ($colors as &$color) {
    $color = strtoupper($color);
}
unset($color); /* ensure that following writes to
```

###类型转换

【新认知】转换为NULL类型，`(unset) $val`

【新认知】将字符串文字和变量转换为二进制字符串 （PS：和想象中不一样）

```php
<?php
$binary = (binary)$string;
$binary = b"binary string";
```


## 语言参考 > 变量

### 变量范围

【旧回顾】 使用`global`，`$GLOBALS` 来实现全局变量或者超全局变量

【新认知】 静态变量只能简单赋值，不能是表达式。静态变量第一次赋值之后不会再被重新定义，可以用于递归函数的计数。

```php
<?php
function test()
{
    static $count = 0;

    $count++;
    echo $count;
    if ($count < 10) {
        test();
    }
    $count--;
}
?>
```
### 来自PHP外的变量
【新认知】变量名中的点和空格被转换成下划线 例如 `<input name="a.b" />` 变成 `$_REQUEST["a_b"]`

## 语言参考 > 流程控制
### foreach 
【新认知】用list()为嵌套数组解包

```php
<?php
$array = [
    [1, 2],
    [3, 4],
];

foreach ($array as list($a, $b)) {
    // $a contains the first element of the nested array,
    // and $b contains the second element.
    echo "A: $a; B: $b\n";
}
?>
```

### break
【新认知】break 可以接受一个可选的数字参数来决定跳出几重循环。```break```  相当于 ```break 1```

### continue 
【新认知】continue 可以接受一个可选的数字参数来决定跳到几重循环结尾。```continue```  相当于 ```continue 1```


## 语言参考 > 常量

### 魔术常量
【新认知】原来这些变量叫做 魔法常量
```php
__LINE __ 
__FILE__
__DIR__
__FUNCTION__
__CLASS__
__TARIT__
__MRTHOD__
__NAMESPACE__
```
## 语言参考 > 类与对象

### 基本概念
【新认知】::class, 使用ClassName::class 可以获得一个字符串，包含命名空间

```php
<?php
namespace NS {
    class ClassName {
    }
    
    echo ClassName::class;
}
?>
//output: NS\ClassName
```

### 类常量

【新认知】接口中可以定义常量
【新认知】可以用一个变量来动态调用类，但该变量的值不能为关键词（self, parent, static）。

### 魔术方法
【新认知】不能在__toString() 方法中抛出异常，这样会出现致命错误。

### 类型约束

【新认知】PHP5 可以使用类型约束，函数的参数可以制定必须为 对象，接口，数组，callable 

### 后期静态绑定

【新认知】后期静态绑定，static:: 不再被解析为定义在当前方法所在的类，而是在实际运行时计算。

```php
<?php
class A {
    public static function who() {
        echo __CLASS__;
    }
    public static function test() {
        static::who(); // 后期静态绑定从这里开始
    }
}

class B extends A {
    public static function who() {
        echo __CLASS__;
    }
}

B::test();
?>
//output: B
```

## 语言参考 > 生成器

【新认知】生成器汗水的核心是yield关键字。它最简单的调用形式看起来像一个return声明，不同之处在于普通return会返回值并终止函数的执行，而yield会返回一个值给循环调用此生成器的代码而且只是暂时执行生成器代码

```php
<?php
function gen_one_to_three() {
    for ($i = 1; $i <= 3; $i++) {
        //注意变量$i的值在不同的yield之间是保持传递的。
        yield $i;
    }
}

$generator = gen_one_to_three();
foreach ($generator as $value) {
    echo "$value\n";
}
?>
```
```
1
2
3
```
## 语言参考 >  预定义变量
### 超全局变量

```php
$GLOBALS
$_SERVER
$_GET
$_POST
$_FILES
$_REQUEST
$_SESSION
$_ENV
$_COOKIE
$php_errormsg //前一个错误信息 
$HTTP_RAW_POST_DATA //原始POST数据
$http_response_header //HTTP Response Header
$argc //argument numbers
$argv //argument array
```


以上

