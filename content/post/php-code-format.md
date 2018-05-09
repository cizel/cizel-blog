---
title: "PHP 代码格式化工具实践"
date: 2017-04-21 T00:20:38+08:00
lastmod: 2018-05-10T00:20:38+08:00
draft: false
keywords: ["实践"]
categories: ["PHP"]
---

本文介绍格式化工具 PHP-CS-Fixer 的安装与使用

<!--more-->

## 安装 PHP-CS-Fixer

```bash
$ wget http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -O php-cs-fixer
```
或者：

```bash
$ curl -L http://cs.sensiolabs.org/download/php-cs-fixer-v2.phar -o php-cs-fixer
```


然后：


```bash
$ sudo chmod a+x php-cs-fixer
$ sudo mv php-cs-fixer /usr/local/bin/php-cs-fixer
```
### Composer

```bash
$ composer global require friendsofphp/php-cs-fixer
```
把 composer 目录加入进`PATH`

```bash
export PATH="$PATH:$HOME/.composer/vendor/bin"
```

### homebrew (Mac)

```bash
brew install homebrew/php/php-cs-fixer
```

## 更新 PHP-CS-Fixer

```bash
$ sudo php-cs-fixer self-update
```

### Composer

```bash
$ ./composer.phar global update friendsofphp/php-cs-fixer
```'



### homebrew

```bash
$ brew upgrade php-cs-fixer
```

## 使用
```bash
$ php-cs-fixer fix /path/to/dir
$ php-cs-fixer fix /path/to/file
```

**参数说明**


|  参数 | 说明 | 默认值 | 可选值 |
| --- | --- | --- | ---|
| --path-mode | 路径模式 | override | override, intersection |
| --format | 输出格式 | txt | txt, json, xml, junit |
| --verbose | 显示应用规则 |  | 
| --rules | 修复规则 |  |  |
| --dry-run | 只运行模式 |  |  |
| --diff | 列出不同 | sbd | sbd, sbd-short|
| --allow-risky | 风险规则(改变代码行为) |  |  | 
| --stop-on-violation | 停止在第一个修复位置 |  |  |
| --show-progress | 展示进程方式 |  | none, run-in, estimating
| --config | 指定配置文件 |  | .php_cs 
| --using-cache | 使用缓存 | true | true, false
| --cache-file | 指定缓存文件 |  | .php_cs.cache

参考： [https://github.com/FriendsOfPHP/PHP-CS-Fixer](https://github.com/FriendsOfPHP/PHP-CS-Fixer)

### VIM
### 安装 vim-php-cs-fixer

Vundle 方式安装

```bash
Plugin 'stephpy/vim-php-cs-fixer'
```

编辑 `.vimrc` 修改 php-cs-fixer 运行配置

```viml
"let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
let g:php_cs_fixer_config_file = '.php_cs' " options: --config

let g:php_cs_fixer_php_path = "php"               " Path to PHP
let g:php_cs_fixer_enable_default_mapping = 1     " Enable the mapping by default (<leader>pcd)
let g:php_cs_fixer_dry_run = 0                    " Call command with dry-run option
let g:php_cs_fixer_verbose = 0                    " Return the output of command if 1, else an inline information.
```

编辑 `.vimrc` 添加keymap

```viml
nnoremap <silent><leader>pcd :call PhpCsFixerFixDirectory()<CR>
nnoremap <silent><leader>pcf :call PhpCsFixerFixFile()<CR>
```


参考: [https://github.com/stephpy/vim-php-cs-fixer](https://github.com/stephpy/vim-php-cs-fixer)

### Sublime Text

#### 安装扩展 Phpcs
`Command Palette` -> `Package Control: Install Package` -> `Phpcs`

#### 添加扩展配置


`Package Setting` -> `PHP Code Sniffer` -> `Setting - User`

```json
{
    // Plugin settings

    // Turn the debug output on/off
    "show_debug": false,

    // Which file types (file extensions), do you want the plugin to
    // execute for
    "extensions_to_execute": ["php"],


    // PHP-CS-Fixer settings

    // Fix the issues on save
    "php_cs_fixer_on_save": true,

    // Show the quick panel
    "php_cs_fixer_show_quick_panel": false,

    // Path to where you have the php-cs-fixer installed
    "php_cs_fixer_executable_path": "/Users/shizhen/.composer/vendor/bin/php-cs-fixer", //php-cs-fixer 的绝对路径

    // Additional arguments you can specify into the application
    "php_cs_fixer_additional_args": {
        "--config":"/Users/shizhen/.php_cs", //.php_cs的绝对路径
        "--using-cache":"no"
    },

}
```
(PS: 查找 `php-cs-fixer` 路径：`$which php-cs-fixer`)

#### 添加快捷键

位置： `Key Binding` 

```json
[
	{ "keys": ["ctrl+super+l"], "command": "phpcs_fix_this_file", "args": {"tool": "Fixer"}},
]

```

### PhpStorm

#### 添加扩展

`Preferences` -> `Tools` -> `External Tools` ->  `+`

![](http://static.cizel.cn/2017-04-24-14927667819143.jpg)

Program: `php-cs-fixer`

Parameters: `fix $FileDir$/$FileName$ --config=.php_cs  --using-cache=no`

Working Directory: `$ProjectFileDir$`

#### 添加快捷键

![](http://static.cizel.cn/2017-04-24-14927673558974.jpg)



参考: [http://tzfrs.de/2015/01/automatically-format-code-to-match-psr-standards-with-phpstorm/](http://tzfrs.de/2015/01/automatically-format-code-to-match-psr-standards-with-phpstorm/)

