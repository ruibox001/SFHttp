# SFHttp

[![Build Status](https://travis-ci.org/robbiehanson/CocoaHTTPServer.svg)](https://travis-ci.org/robbiehanson/CocoaHTTPServer)

一、SFHttp 是基于AFNetworking的封装的网络请求类，主要扩展如下功能：<br>
1、请求采用链试调用<br>
2、网络请求内置YYModel的解析模型<br>
3、自动解析传入的模型并返回<br>
4、网络变化监听<br>

二、请求代码示例<br>
1、get请求调用：<br>

get<br>
.url(@"http://www.weather.com.cn/data/sk/101110101.html")<br>
.resolve(@"weatherinfo",@"MyModel",^(id model){<br>
        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;if ([model isKindOfClass:[MyModel class]]) {<br>
            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;NSLog(@"\n解析返回：%@",model);<br>
        }<br>
        else if ([model isKindOfClass:[NSArray class]]){<br>
            for (MyModel *p in model) {<br>
                NSLog(@"\n数组解析返回：%@",p);<br>
            }<br>
        }<br>
   })<br>
   .start();<br>

2、post请求调用：<br>

post<br>
.url(@"http://www.weather.com.cn/data/sk/101110101.html")<br>
.addPara(@{@"userId":@"111"})<br>
.addPara(@{@"userName":@"222"})<br>
.resolve(@"weatherinfo",@"MyModel",^(id model){<br>
        if ([model isKindOfClass:[MyModel class]]) {<br>
            NSLog(@"\n解析返回：%@",model);<br>
        }<br>
        else if ([model isKindOfClass:[NSArray class]]){<br>
            for (MyModel *p in model) {<br>
                NSLog(@"\n数组解析返回：%@",p);<br>
            }<br>
        }<br>
   })<br>
   .start();<br>

三、请求返回信息<br>
请求信息:<br>
URL: http://www.weather.com.cn/data/sk/101110101.html <br>
参数: {<br>
    userId = 111;<br>
    userName = 222;<br>
} <br>
JSON: {<br>
  "weatherinfo" : {<br>
    "temp" : "20",<br>
    "time" : "17:00",<br>
    "WD" : "西南风",<br>
    "qy" : "970",<br>
    "isRadar" : "1",<br>
    "cityid" : "101110101",<br>
    "city" : "西安",<br>
    "WS" : "1级",<br>
    "WSE" : "1",<br>
    "Radar" : "JC_RADAR_AZ9290_JB",<br>
    "njd" : "暂无实况",<br>
    "SD" : "14%",<br>
    "rain" : "0"<br>
  }<br>
}<br>
2017-09-11 09:10:41.208595+0800 SFRequest[3842:1055264] <br>
解析返回：17:00 - 西南风 - 西安 - 暂无实况 - 20
