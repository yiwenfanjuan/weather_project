class HttpContant {
  //定义请求成功的状态码
  static const int HTTP_SUCCESS = 200;
  //定义Http请求成功的message
  static const String HTTP_SUCCESS_MSG = "http_success";

  //定义数据请求成功的状态码
  static const String REQUEST_SUCCESS = "0";
  //定义数据请求成功的message
  static const String REQUEST_SUCCESS_MSG = "request_success";
  //请求到的数据不是标准的json数据
  static const String REQUEST_FAILED_NOT_JSON = "ERROR_1";
  static const String REQUEST_FAILED_NOT_JSON_MSG = "ERROR:data is not json";

  //请求出错，未知原因
  //定义数据请求成功的状态码
  static const String REQUEST_FAILED = "-1";
  //定义数据请求成功的message
  static const String REQUEST_FAILED_MSG = "request_error : unkonw reason";


  //获取当前天气实况信息的路径
  static const String NOW_WEATHER_PATH = "weather/now.json";
  //获取当前空气质量信息的数据
  static const String AIR_INFO_PATH = "air/now.json";
  //获取未来24小时天气信息的路径
  static const String FUTURE_HOURLY_PATH = "weather/hourly.json";
  //获取未来5天的天气情况
  static const String FUTURE_DAILY_PATH = "weather/daily.json";
  //获取生活指数信息
  static const String SUGGESTION_INFO_PATH = "life/suggestion.json";
  //根据用户输入搜索城市信息
  static const String CITY_SEARCH_PATH = "location/search.json";
}
