---
title: "IDEA Postfix Completion 补全小技巧"

date: 2020-02-13
lastmod: 2020-02-13

keywords: ["postfix", "学习笔记"]

tags: ["postfix"]
categories: ["开发者手册"]

draft: false
---

自从做 Java 开发之后，IDEA 编辑器是不可少的。

在 IDEA 编辑器中，有很多高效的代码补全功能，尤其是 Postfix  Completion 功能，可以让编写代码更加的流畅。

<!--more-->

Postfix completion 本质上也是代码补全，它比  Live Templates 在使用上更加流畅一些，我们可以看一下下面的这张图。

![show_postfix](https://static.cizel.cn/2020-02-14-show_postfix.gif)

## 设置界面

可以通过如下的方法打开 Postfix 的设置界面，并开启 Postfix。

![](https://static.cizel.cn/2020-02-14-15816391006391.jpg)

## 常用的 Postfix 模板

### boolean 变量模板

`!`: **Negates boolean expression**

```java
//before
public class Foo {
     void m(boolean b) {
         m(b!);
     }
 }
 
//after
public class Foo {
    void m(boolean b) {
        m(!b);
    }
}
```

`if`: **Checks boolean expression to be 'true'**

```java
//before
public class Foo {
    void m(boolean b) {
        b.if
    }
}

//after
public class Foo {
    void m(boolean b) {
        if (b) {

        }
    }
}
```

`else`: **Checks boolean expression to be 'false'.**

```java
//before
public class Foo {
    void m(boolean b) {
        b.else
    }
}

//after
public class Foo {
    void m(boolean b) {
        if (!b) {

        }
    }
}
```

### array 变量模板

`for`: **Iterates over enumerable collection.**

```java
//before
public class Foo {
    void m() {
        int[] values = {1, 2, 3};
        values.for
    }
}

//after
public class Foo {
    void m() {
        int[] values = {1, 2, 3};
        for (int value : values) {

        }
    }
}
```

`fori`: **Iterates with index over collection.**

```java
//before
public class Foo {
    void m() {
        int foo = 100;
        foo.fori
    }
}

//after
public class Foo {
    void m() {
        int foo = 100;
        for (int i = 0; i < foo; i++) {

        }
    }
}
```

### 基本类型模板

`opt`: **Creates Optional object.**

```java
//before
public void m(int intValue, double doubleValue, long longValue, Object objValue) {
  intValue.opt
  doubleValue.opt
  longValue.opt
  objValue.opt
}

//after
public void m(int intValue, double doubleValue, long longValue, Object objValue) {
  OptionalInt.of(intValue)
  OptionalDouble.of(doubleValue)
  OptionalLong.of(longValue)
  Optional.ofNullable(objValue)
}
```

`sout`: **Creates System.out.println call.**

```java
//before
public class Foo {
  void m(boolean b) {
    b.sout
  }
}

//after
public class Foo {
  void m(boolean b) {
      System.out.println(b);
  }
}
```



### Object 模板

`nn`: **Checks expression to be not-null.**

```java
//before
public class Foo {
    void m(Object o) {
        o.nn
    }
}
//after
public class Foo {
    void m(Object o) {
        if (o != null){

        }
    }
}
```

`null`: **Checks expression to be null.**

```java
//before
public class Foo {
    void m(Object o) {
        o.null
    }
}
//after
public class Foo {
    void m(Object o) {
        if (o != null){

        }
    }
}
```

`notnull`: **Checks expression to be not-null.**

```java
//before
public class Foo {
    void m(Object o) {
        o.notnull
    }
}
//after
public class Foo {
    void m(Object o) {
        if (o != null){

        }
    }
}
```

`val`: **Introduces variable for expression.**

```java
//before
public class Foo {
    void m(Object o) {
        o instanceof String.var
    }
}

//after
public class Foo {
    void m(Object o) {
        boolean foo = o instanceof String;
    }
}
```

### 其他模板

`new`: **Inserts new call for the class.**

```java
//before
Foo.new

//after
new Foo()
```
`return`: **Returns value from containing method.**

```java
//before
public class Foo {
    String m() {
        "result".return
    }
}
//after
public class Foo {
    String m() {
        return "result";
    }
}
```
