class Constant {
  //数据请求出错，未知错误类型
  static const String ERROR_UNKNOW = "unknow";
  //请求成功
  static const int DATA_SUCCESS = 0;
  //数据请求出错，未知错误类型代码
  static const int ERROR_UNKNOW_CODE = -1;
  //数据请求出错，返回的数据类型不对，不是map
  static const int ERROR_DATA_TYPE = -2;
  //数据请求成功，但是没有内容
  static const int ERROR_DATA_EMPTY = -3;

  //数据类型出错的提示
  static const String ERROR_DATA_TYPE_MESSAGE = "请求到的数据类型不是Map";
  //出现异常但是不知道具体异常的提示
  static const String ERROR_EXCEPTION_UNKNOW= "未知异常";

  //请求成功的提示
  static const String DATA_SUCCESS_MESSAGE = "数据请求成功";

  //数据内容为空的提示信息
  static const String ERROR_DATA_EMPTY_MESSAGE = "数据为空";

  //未知错误类型时的提示文字
  static const String ERROR_UNKNOW_MESSAGE = "数据请求出错，未知错误类型";
  //网络请求成功的状态码
  static const int HTTP_REQUEST_SUCCESS = 200;

  //数据请求包含的字段
  static const String DATA_STATUS = "status";
  static const String DATA_STATUS_CODE = "status_code";
  static const String DATA_MESSAGE = "message";
  static const String DATA_CODE ="code";
  static const String DATA_IS_SUCCESS = "success";
  static const String DATA_RESULT = "data";

  //包含请求到的数据的key
  static const String DATA_KEY = "results";

  //最大允许获取5个城市的数据
  static const int MAX_CITY_VALUE = 5;

  //数据库操作事件常量
  static const String DATABASE_INSERT_LOCATION ="databaseChange";
}