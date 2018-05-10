---
title: "PHP实现手机归属地查询"
date: 2016-04-11T17:48:39+08:00
lastmod: 2018-05-10T00:20:38+08:00
draft: false
categories: ["PHP"]
---

> 最近经常在开慕课网上的课程, 动手完成 PHP 实现手机归属地查询的功能。

<!--more-->

![](https://static.cizel.cn/2018-05-09-15258698172904.jpg)

## 后台类结构

MobileQuery类调用:
 - \libs\HttpRquest
 - \libs\ImRedis (未使用)

Api类调用 MobileQuery 类的 Query 方法来返回 $response 的数据，并进行加工。

## 前台类结构

base.js 使用 .ajax 请求，并将请求后的数据填充到index.html 中。

## 核心代码展示

### AutoLoad.php

```php
<?php

class AutoLoad {

	 public static function load($className)
    {
        //命名空间的反斜杠替代
        $filename = sprintf('%s.php',str_replace('\\','/',$className));
        require_once($filename);
    }
}
spl_autoload_register(['AutoLoad','load']);

```

### Api.php

```php
<?php

require_once "AutoLoad.php";
use \app\MobileQuery;
class Api{
	private $response;
	private $params;
	private $phone;
	public function __construct(){
		$this->params = $_POST;
		if(isset($this->params['tel'])) {
			$this->phone = $this->params['tel'];
		}else {
			$this->phone  =  '17706436202';
		}
		$this->queryResponse($this->phone);
	}
	public function queryResponse($phone) {
		$this->response = MobileQuery::query($phone);
		if(is_array($this->response) and isset($this->response['province'])) {
			$this->response['phone'] = $phone;
			$this->response['code'] = 200;
		} else {
			$this->response['phone'] = $phone;
			$this->response['msg'] = '手机号码错误';
		}
	}
	public function getResponse()
	{
		return json_encode($this->response);
	}
}
$Api = new Api();
echo $Api->getResponse();

```

### app/MobileQuery.php

```php
<?php
/**
 * TODO Auto-generated comment.
 */
namespace app;

use libs\HttpRequest;
use libs\ImRedis;

class MobileQuery {
	/**
	 * TODO Auto-generated comment.
	 */
	const PHONE_API= 'https://tcc.taobao.com/cc/json/mobile_tel_segment.htm';
	/**
	 * TODO Auto-generated comment.
	 */
	const QUERY_PHONE = 'PHONE:INFO:';

	public static function query($phone)
	{
		$phoneData =  null;
		if(self::varifyPhone($phone)){
			$response = HttpRequest::request(self::PHONE_API, ['tel'=>$phone]);
			$phoneData = self::formatData($response);
			$phoneData['msg'] ='数据由Cizel的博客提供';
		}
		return $phoneData;
	}

	public static function formatData($data)
	{
		$ret = null;
		if(!empty($data)){
			preg_match_all("/(\w+):'([^']+)/",$data,$res);
			$items = array_combine($res[1],$res[2]);
			foreach ($items as $itemKey => $itemVal) {
				$ret[$itemKey] = iconv('GB2312','UTF-8',$itemVal);
			}
		}
		return $ret;
	}

	public static function varifyPhone($phone)
	{
		if(preg_match("/^1[34578]{1}\d{9}/",$phone)) {
			return true;
		} else {
			return false;
		}
	}
}

```

# lib/HttpRequest.php

```php
<?php
/**
 * TODO Auto-generated comment.
 */
namespace libs;

class HttpRequest {

	/**
	 * TODO Auto-generated comment.
	 */
	public static function request($url, $params =[], $method='GET')
	{
		$ret = null;
		if(preg_match("/^(http|https)\:\/\/(\w+\.\w+\.\w+)/",$url)) {
			$method = strtoupper($method);
			if($method == 'POST') {
				exit('nothing to do.');
			} else {
				if($params) {
					 if(strripos('?',$url)) {
					 	$url = $url . '&' . http_build_query($params);
					 } else {
					 	$url = $url . '?' . http_build_query($params);
					 }
				}
				$ret = file_get_contents($url);
			}
		}
		return $ret;
	}
}

```

### statis/js/base.js

```js
/*
* @Author: Cizel
* @Date:   2016-04-11 16:53:52
* @Last Modified by:   Cizel
* @Last Modified time: 2016-04-11 17:22:32
*/

$(document).ready(function(){
    $('#query').click(function(){
    	var phone = $('#phone_num').val();
    	//alert(phone);
    	if (phone.length == 11) {
    		Cizel.GLOBAL.AJAX('Api.php','post',{'tel':phone},'json',Cizel.APPS.QUERYPHONE.AJAXCALLBACK);
    	}
    });
 });

var Cizel = Cizel || {};
Cizel.GLOBAL = {};
Cizel.APPS = {};

Cizel.APPS.QUERYPHONE = {};
Cizel.APPS.QUERYPHONE.AJAXCALLBACK = function(data){
	if(data.code == 200){
		Cizel.APPS.QUERYPHONE.SHOWINFO();
		$('#phoneNumber').text(data.phone);
		$('#phoneProvince').text(data.province);
		$('#phoneCatName').text(data.catName);
		$('#phoneMsg').text(data.msg);
	} else {
		Cizel.APPS.QUERYPHONE.HIDEINFO();
	}
};
Cizel.APPS.QUERYPHONE.SHOWINFO = function(){
	$('#phoneInfo').show();
}
Cizel.APPS.QUERYPHONE.HIDEINFO = function(){
	$('#phoneInfo').hide();
}

Cizel.GLOBAL.AJAX = function(url, method, params,dataType,callBack)
{
	$.ajax({
		url: url,
		type: method,
		data: params,
		dataType: dataType,
		success:callBack,
		error:function(){
			alert('请求异常');
		}

	});
};
```

## 感悟

通过完成这个实例，感觉自己对 PHP 面向对象的编写有了新的理解，同时 JavaScript 的编写能力需要加强。

## 代码地址

[https://github.com/cizel/TryMyBest/tree/master/queryPhone](https://github.com/cizel/TryMyBest/tree/master/queryPhone)
