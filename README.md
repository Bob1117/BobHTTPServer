## BobHTTPSever 
[TOC]
### 功能介绍
1. 是基于cocoaHTTPServer实现的在ios端搭建的app内置服务器。
2. 做了保持程序退出后台服务器依旧运行的处理，可以通过设置port自定义端口。
3. 主要功能是app与safari中的h5进行交互、信息的传递，也可以进行本地app与app之间的通信。

### 注意事项
         1. 要以folder 的形式添加web文件，也就是说文件在工程中是绿色的

	2. PrefixHeader.pch文件，需要设置其路径通过在Build Setting中搜索Prefix Header关联其路径。
	3. 开启服务器必须在UIApplication.m中实现。
	
### demo中实现的功能

1. 在编辑框中，输入的文本，通过按钮都能触发写入app服务器接口，通过按钮跳入safari访问，也可以在safari中输入 localhost:12345/apps访问
2. 如果app想接受h5的传值，可以通过CCHTTPConnection.m这个类来监听访问情况来获取相应的值，详见Demo。
3. 监测服务器是否开启成功，可以在safari中输入localhost:12345会加载显示出app服务器中的html文件。 
4. 还可以实现服务器所具备的很多其他的功能，具体后续再追加补充

### 探讨联系方式
如果任何问题，可以咨询：379527689
或者发邮件：honesteffort@163.com

