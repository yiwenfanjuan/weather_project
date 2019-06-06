import 'dart:io';
import 'package:dio/dio.dart';
/**
 * 通过单例模式构造dio的http请求
 */
class HttpClient {

  static Dio _dio;

  static Dio getDio() {
    if (_dio == null) {
      _initDio();
    }
    return _dio;
  }

  //初始化dio并且进行相关配置
  static void _initDio() {
    BaseOptions options = BaseOptions();
    //使用post方式请求数据
    options.method = "GET";
    //请求基地址
    options.baseUrl = "https://api.seniverse.com/v3/";
    //链接服务器的超时时间
    options.connectTimeout = 60000;
    //接收数据的最长时限
    options.receiveTimeout = 60000;
    //contentType
    ContentType type = ContentType.parse("application/x-www-form-urlencoded");
    options.contentType = type;

    //接收数据的类型
    options.responseType = ResponseType.json;

    _dio = Dio(options);
  }


}
