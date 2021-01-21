---
title: "数学建模部分模型代码示例"
date: 2016-06-16
lastmod: 2016-06-16
draft: false
keywords: ["数学建模", "matlab"]
tags: ["数学建模", "matlab"]
categories: ["观点与感悟"]
---

参加数学建模时候，记录了一些模型使用 Mablab 编程的示例。

<!--more-->

## 部分模型的示例

分别是当时参加数学建模留下来的一些模型的示例，分别是：散点图画 3D 立体图，层次分析法，模糊数学模型，神经网络模型。

### 散点图画 3D 立体图

```matlab
clc,clear;
load('.\matlab.mat'); %x,y,z数据
%得到x，y，z的数据
x=data(:,1);
y=data(:,2);
z=data(:,3);
xmin=min(x);xmax=max(x);    %x的最大，最小值
ymin=min(y);ymax=max(y);    %y的最大，最小值
x0=linspace(xmin,xmax,100);    %x最大到最小分100份
y0=linspace(ymin,ymax,100);    %y最大到最小分100份
[x0,y0]=meshgrid(x0,y0);        %x0，y0立方体
z0=griddata(x,y,z,x0,y0,'v4');  %差值法，插入数据，'linear' 'cubic' 'nearest' 'v4' 4种参数类型

surf(x0, y0, z0);
```


### 层次分析法

```matlab
clc,clear %function stepAnalysis 主函数
%第一步，建立层次结构,常量的定义

%第二步，构造成对比较矩阵
A=[1,1/2,4,3,3
    2,1,7,5,5
    1/4,1/7,1,1/2,1/3
    1/3,1/5,2,1,1
    1/3,1/5,3,1,1];
B{1}=[1 2 5
    1/2 1 2
    1/5 1/2 1];
B{2}=[1 1/3 1/8
    3 1 1/3
    8 3 1];
B{3}=[1 1 3
    1 1 3
    1/3 1/3 1];
B{4}=[1 3 4
    1/3 1 1
    1/4 1 1];
B{5}=[1 1 1/4
    1 1 1/4
    4 4 1];
%第三步，计算准侧层A的最大特征值，归一化的特征向量，CI,RI,CR
Wi=featureVectorW(A);
CRn=ConsistencyCR(A);

for i=1:5
    W{i}=featureVectorW(B{i});
    CR{i}=ConsistencyCR(B{i});
end

Wn=[W{1},W{2},W{3},W{4},W{5}];
B=Wn*Wi;
```

```matlab
function W=featureVectorW(matrix) %计算特征向量
    [x,y]=eig(matrix);%[V,D]=eig(A)：求矩阵A的全部特征值，构成对角阵D，并求A的特征向量构成V的列向量。
    W=x(:,1)/sum(x(:,1));
end
```

```matlab
function CR=ConsistencyCR(matrix)  %计算CR的一致性比率
    RI  = [0 0 0.5200 0.8900 1.1200 1.2600 1.3600 1.4100 1.4600 1.4900 1.5200 1.5400 1.5600 1.5800 1.5900];%定义RI常量
    [x,y]=eig(matrix); %[V,D]=eig(A)：求矩阵A的全部特征值，构成对角阵D，并求A的特征向量构成V的列向量。
    lamda=max(max(y));%最大特征值
    len=length(matrix); %计算矩阵的长度
    CI=(lamda-len)/(len-1); %CI的计算
    CR=CI/RI(len);
end
```


### 模糊数学模型

```matlab
clc,clear %主程序
A=[55 20 25 0 10
    25 10 40 25 15.2
    15 0 55 30 19.5
    45 10 40 5 10.1
    40 20 40 0 10
    45 30 25 0 9.01
    ];
R=maxFormat(A);
%闭包测试
Rn{1}=closure(R)
for i=2:5
    Rn{i}=closure(Rn{i-1});
    if Rn{i}==Rn{i-1}
        break;
    end
end
temp=unique(Rn{2});
rows=size(temp,1);
for i=1:6
    t{i}=zeros(6,6);
    for j=1:6
       for k=1:6
            if Rn{3}(j,k)>=temp(rows-i+1);
               t{i}(j,k)=1;
            end
       end
    end
end
```

```matlab
function X=maxFormat(matrix)  %最大值规格化
    c=max(matrix);
    for i=1:size(matrix,2)
    matrix(:,i)=matrix(:,i)/c(i);
    end
    X=ones(6,6);
    for i=1:6
       for j=1:6
           temp=[matrix(i,:);matrix(j,:)];
           X(i,j)=sum(min(temp))/sum(max(temp));
       end
    end
end
```

```matlab
function  X=closure(last)  %闭包测试
    for i=1:6
       for j=1:6
           temp=[last(i,:);last(:,j)'];
           X(i,j) = max(min(temp));
      end
    end
end
```

### 神经网络模型

```matlab
clear
p1=[1.24,1.27;1.36,1.74;1.38,1.64;1.38,1.82;1.38,1.90;
1.40,1.70;1.48,1.82;1.54,1.82;1.56,2.08];
p2=[1.14,1.82;1.18,1.96;1.20,1.86;1.26,2.00
1.28,2.00;1.30,1.96];
p=[p1;p2]’;
pr=minmax(p); %input data
goal=[ones(1,9),zeros(1,6);zeros(1,9),ones(1,6)];%target data
plot(p1(:,1),p1(:,2),'h',p2(:,1),p2(:,2),'o') %点的分布
%创建神经网络
net=newff(pr,[3,2],{'logsig','logsig'});
%设置训练参数
net.trainParam.show = 10;
net.trainParam.lr = 0.05;
net.trainParam.goal = 1e-10; %精度
net.trainParam.epochs = 50000;%最大步长
%开始训练
net = train(net,p,goal);
%仿真
x=[1.24 1.80;1.28 1.84;1.40 2.04]’;
y0=sim(net,p);
y=sim(net,x);
```

```matlab
clear
p1=[1.24,1.27;1.36,1.74;1.38,1.64;1.38,1.82;1.38,1.90;
1.40,1.70;1.48,1.82;1.54,1.82;1.56,2.08];
p2=[1.14,1.82;1.18,1.96;1.20,1.86;1.26,2.00
1.28,2.00;1.30,1.96];
p=[p1;p2]'
pr=minmax(p)
goal=[ones(1,9),zeros(1,6);zeros(1,9),ones(1,6)]
net = newlvq(pr,4,[0.6,0.4])
net = train(net,p,goal)
Y = sim(net,p)
x=[1.24 1.80;1.28 1.84;1.40 2.04]'
sim(net,x)
```

## 常用函数

### `size(a, b)`

```matlab
A=ones(3,4);
size(A); % echo  3 4
size(A,1); %echo 3
size(A,2); %echo 4
```

### `unique()`

```matlab
A = [1 1 5 6 2 3 3 9 8 6 2 4]
[b1, m1, n1] = unique(A, 'first');
%b2 = 1   2   3   4   5   6   8   9
%m2 = 2  11   7  12   3  10   9   8
%n2 = 1   1   5   6   2   3   3   8   7   6   2   4
```

## 后记

这些是参加数学建模时候总结的笔记，留给回忆。


