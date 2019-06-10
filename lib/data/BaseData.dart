
/**
 * 请求到的数据信息
 */

class BaseData {

  //status是服务器返回的错误信息
  //状态信息，请求出错的时候会显示
  String status;
  //错误码
  int status_code;

  
  //code是http请求出错，message表示出错的信息，如果http请求出错则为对应的错误信息，如果是服务器返回了出错信息则为status对应的信息
  String message;
  //请求回调的http状态码
  int code;

  //是否请求成功，默认情况下Http请求返回数据并且数据解析成功后认为成功
  bool success;
  //请求到的数据，请求成功后的Map数据
  Map data;

  BaseData();

  
}
