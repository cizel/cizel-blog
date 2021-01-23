---
title: "正方教务一键评价 JS 脚本"

date: 2016-07-09
lastmod: 2018-11-21

keywords: ["正方教务", "一键评价"]

tags: ["正方教务", "一键评价"]
categories: ["剪贴板"]

draft: true
---

代码来着网络，经过修复可以正常的完成一件评教功能。

<!--more-->

外挂在此：

```javascript
(function(){
    var done = false;
    var length = document.getElementById("zhuti").contentWindow.document.getElementById("pjkc").getElementsByTagName("option").length;
    var count = 0;

    try{
        var setAll = function(){
            var selects = document.getElementById("zhuti").contentWindow.document.getElementsByClassName("datelist")[0].getElementsByTagName("select");
            var randI=Math.floor(Math.random()*8);
            for(var i =0; i < selects.length;i++){
            	if(i==randI){
            		selects[i].value="良好";
            	}else{
            		selects[i].value="优秀";
            	}

            };
        };
        var submitData = function(){
            if(done) return;
            if(count >= length) {
                console.log("all done, have fun!");
                done = true;
                document.getElementById("zhuti").contentWindow.document.getElementById("Button2").click();
                return;
            }
            count ++;
            document.getElementById("zhuti").contentWindow.document.getElementById("Button1").click();
        };
        document.getElementById("zhuti").addEventListener("load", function(){
            setAll();
            submitData();
        });
        setAll();
        submitData();
    }
    catch(e){
        done = true;
    }
})();
```

```javascript
javascript:(function(){var done=false;var length=document.getElementById('zhuti').contentWindow.document.getElementById('pjkc').getElementsByTagName('option').length;var count=0;try{var setAll=function(){var selects=document.getElementById('zhuti').contentWindow.document.getElementsByClassName('datelist')[0].getElementsByTagName('select');var randI=Math.floor(Math.random()*8);for(var i=0;i<selects.length;i++){if(i==randI){selects[i].value='%E8%89%AF%E5%A5%BD'}else{selects[i].value='%E4%BC%98%E7%A7%80'}}};var submitData=function(){if(done)return;if(count>=length){console.log('all done, have fun!');done=true;document.getElementById('zhuti').contentWindow.document.getElementById('Button2').click();return}count++;document.getElementById('zhuti').contentWindow.document.getElementById('Button1').click()};document.getElementById('zhuti').addEventListener('load',function(){setAll();submitData()});setAll();submitData()}catch(e){done=true}})();
```
