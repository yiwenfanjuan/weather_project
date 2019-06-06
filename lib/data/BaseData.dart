
/**
 * 请求到的数据信息
 */

class BaseData<T> {
  //状态信息，请求出错的时候会显示
  String status;
  //错误码
  String status_code;
  //其它错误信息
  String message;
  //请求回调的http状态码
  int code;

  //请求到的数据
  T data;

  BaseData();

  BaseData.fromJson(Map<String, dynamic> json)
      : this.code = json["code"],
        this.status = json["status"],
        this.status_code = json["status_code"],
        this.message = json["message"],
        this.data = json["data"];
}
