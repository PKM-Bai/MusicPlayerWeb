## 项目使用指南

### 准备工作

1.首先下载使用 IDEA 作为开发工具

2.Tomcat 9.0.37版本（最好8.0以上）


### 预览

<video src="./项目预览.mp4" controls="controls" width="1200" height="600"></video>


### 项目本地化配置

#### 通过IDEA打开该项目，要记得存放路径，还要等待IDEA构建部署项目。

![image-20230528155936237](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/d39ece23-86fc-42c6-a1fe-b53d988b52c7)


#### 1、Utils/Tools.java

![image-20230528160719948](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/63305ba0-c2f6-43cb-ab7b-4e6339dfa00d)




#### 2、applicationContext.xml

![image-20230528160555315](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/821f6be1-3a7a-4b27-9d35-66f4df27e489)




### 运行项目

#### 创建数据库

![image-20230528160927768](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/ba270b88-a01a-43f5-8029-b2b5a79f142a)




#### Tomcat的参数

![image-20230528161012418](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/01b715b7-3744-40ae-a861-2dc343f2350a)


![image-20230528161020093](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/520463bd-5f65-4e59-bc9f-15a095121b16)




启动Tomcat成功后，浏览器访问http://localhost:8080/MusicPlayerWeb/ 。初次启动后页面应该是这样的。

![image-20230528161320938](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/b0ee2c42-7fc3-4d96-b182-86e1673bc5e6)


点击右上角登录 —> 初始化数据库，初始化成功后会刷新页面，并且显示出歌曲列表与轮播图，如果正确显示出来了，表示你已经将项目成功跑起来了！

![image-20230528161459621](https://github.com/PKM-Bai/MusicPlayerWeb/assets/95196320/8cf958bf-f34d-449a-95d1-4de68a27387d)






## 注意事项

还有很多功能没有完善，或者说不智能，等之后时间长了再修改。比如所有的资源都是已本地化静态资源方式读取的，需要更换的头像、歌曲、歌词、背景图片等等，都要放在"MusicPlayerWeb\src\main\webapp\resources\"目录下，存放好之后再重新启动Tomcat部署才有效果。
