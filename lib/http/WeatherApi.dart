import 'dart:async';
import 'dart:collection';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:weather_project/data/BaseData.dart';
import 'package:weather_project/data/air/AirResultInfo.dart';
import 'package:weather_project/data/constant.dart';
import 'package:weather_project/data/life/LifeSuggestionInfo.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
import 'package:weather_project/data/weather/FutureDailyWeatherInfo.dart';
import 'package:weather_project/data/weather/FutureHourlyWeatherInfo.dart';
import 'package:weather_project/data/weather/NowWeatherEntity.dart';
import 'package:weather_project/http/HttpContant.dart';
import 'DioHttpClient.dart';

/**
 * 天气相关的Api信息
 */
class WeatherApi<D> {
  //构建Http请求
  /**
   * path 请求的路径
   * params 传递的数据
   * containKey 根据当前key判断数据是否真的请求成功
   */
  Future<Map<String, dynamic>> getResponse(
      String path, Map<String, dynamic> params,
      {String containKey = Constant.DATA_KEY}) async {
    Dio dio = HttpClient.getDio();
    params["key"] = "SjFcDpOpiVPJ4eEDw";
    try {
      Response response = await dio.get(path, queryParameters: params);
      print(
          "$path 请求到的数据: ${response.statusCode} \n ${response.headers.toString()} \n ${response.data}}");
      if (response != null) {
        return notEmptyResponse(response, key: containKey);
      } else {
        //response为空
        return emptyResponse();
      }
    } catch (e) {
      //请求过程中出现异常
      return errorResponse(e);
    }
  }

  //请求过程中出现异常
  Map<String, dynamic> errorResponse(Exception exception) {
    Map<String, dynamic> map = HashMap();
    if (exception != null) {
      map = writeMap(Constant.ERROR_UNKNOW_CODE, exception.toString(),
          Constant.ERROR_UNKNOW_CODE, Constant.ERROR_UNKNOW_MESSAGE, false);
    } else {
      map = writeMap(
          Constant.ERROR_UNKNOW_CODE,
          Constant.ERROR_EXCEPTION_UNKNOW,
          Constant.ERROR_UNKNOW_CODE,
          Constant.ERROR_UNKNOW_MESSAGE,
          false);
    }
    return map;
  }

  //当请求到的response不为空的时候返回的数据
  Map<String, dynamic> notEmptyResponse(Response response, {String key}) {
    Map<String, dynamic> map;
    if (response.statusCode == Constant.HTTP_REQUEST_SUCCESS) {
      //状态码正确，判断返回的数据类型是否正确
      if (response.data is Map) {
        //数据类型正确，暂时将success设置为true
        //判断是否存在需要比较的key
        if (key != null) {
          if (response.data.containsKey(key)) {
            //包含当前key
            map = writeMap(
                response.statusCode,
                Constant.DATA_SUCCESS_MESSAGE,
                Constant.DATA_SUCCESS,
                Constant.DATA_SUCCESS_MESSAGE,
                true,
                data: response.data);
          } else if (response.data.containsKey(Constant.DATA_STATUS_CODE)) {
            map = writeMap(
              response.statusCode,
              response.data[Constant.DATA_STATUS],
              response.data[Constant.DATA_STATUS_CODE],
              response.data[Constant.DATA_STATUS],
              false,
            );
          } else {
            map = writeMap(
              response.statusCode,
              Constant.ERROR_UNKNOW_MESSAGE,
              Constant.ERROR_UNKNOW_CODE,
              Constant.ERROR_UNKNOW_MESSAGE,
              false,
            );
          }
        } else {
          map = writeMap(response.statusCode, Constant.ERROR_DATA_TYPE_MESSAGE,
              Constant.ERROR_DATA_TYPE, Constant.ERROR_DATA_TYPE_MESSAGE, true,
              data: response.data);
        }
      } else {
        map = writeMap(response.statusCode, Constant.ERROR_DATA_TYPE_MESSAGE,
            Constant.ERROR_DATA_TYPE, Constant.ERROR_DATA_TYPE_MESSAGE, false);
      }
    } else {
      //状态码不对
      map = writeMap(
          response.statusCode,
          getErrorCodeMessage(response.statusCode),
          Constant.ERROR_UNKNOW_CODE,
          Constant.ERROR_UNKNOW,
          false);
    }
    return map;
  }

  //根据不同的状态码返回不同的提示信息
  String getErrorCodeMessage(int errorCode) {
    String errorMessage;
    switch (errorCode) {
      case 100:
        errorMessage = "请继续响应";
        break;
      case 101:
        errorMessage = "切换协议";
        break;
      case 200:
        errorMessage = "数据请求成功";
        break;
      case 300:
        errorMessage = "多种资源被发现";
        break;
      case 301:
        errorMessage = "请求的资源已被永久移动新的地址";
        break;
      case 302:
        errorMessage = "请求的资源被临时移动到新的地址";
        break;
      case 305:
        errorMessage = "请使用代理访问";
        break;
      case 307:
        errorMessage = "临时重定向";
        break;
      case 400:
        errorMessage = "客户端请求的语法错误";
        break;
      case 401:
        errorMessage = "需要验证身份";
        break;
      case 403:
        errorMessage = "服务器拒绝执行此请求";
        break;
      case 404:
        errorMessage = "未找到相关资源";
        break;
      case 405:
        errorMessage = "请求的方法被禁止";
        break;
      case 406:
        errorMessage = "无法完成请求";
        break;
      case 500:
        errorMessage = "服务器内部错误";
        break;
      default:
        errorMessage = "未知错误信息";
        break;
    }
    return errorMessage;
  }

  //当请求到的response为空时返回的数据
  Map<String, dynamic> emptyResponse() {
    return writeMap(Constant.ERROR_UNKNOW_CODE, Constant.ERROR_UNKNOW_MESSAGE,
        Constant.ERROR_UNKNOW_CODE, Constant.ERROR_UNKNOW, false);
  }

  //map中设置的数据信息
  Map<String, dynamic> writeMap(
      int code, String message, int status_code, String status, bool isSuccess,
      {Map<String, dynamic> data}) {
    Map<String, dynamic> map = HashMap();
    map[Constant.DATA_STATUS_CODE] = status_code;
    map[Constant.DATA_STATUS] = status;
    map[Constant.DATA_CODE] = code;
    map[Constant.DATA_MESSAGE] = message;
    map[Constant.DATA_IS_SUCCESS] = isSuccess;
    if (isSuccess) {
      map.addAll(data);
    }
    return map;
  }

  //判断数据是否正确
  bool checkMap(Map<String, dynamic> map) {
    return map[Constant.DATA_IS_SUCCESS];
  }

  //设置没有请求到数据
  void setDataEmptyError(BaseData entity) {
    entity.success = false;
    entity.message = Constant.ERROR_DATA_EMPTY_MESSAGE;
    entity.status_code = Constant.ERROR_DATA_EMPTY;
    entity.status = Constant.ERROR_DATA_EMPTY_MESSAGE;
  }

//获取当前所在地区的天气实况
  Future<NowWeatherListEntity> doNowWeather(String cityName) async {
    Map<String, dynamic> params = HashMap();
    params["location"] = cityName ?? "beijing";

    Map<String, dynamic> data =
        await getResponse(HttpContant.NOW_WEATHER_PATH, params);

   

    NowWeatherListEntity entity = NowWeatherListEntity.fromJson(data);
    if (entity.success) {
      //数据请求成功,这里需要继续对比，如果请求到的数据列表不为空则认为数据完全成功，否则认为数据
      if (entity.results == null || entity.results.isEmpty) {
        setDataEmptyError(entity);
      }
    }
    return entity;
  }

  //请求所在地区的空气质量信息
  /**
   * location 位置信息：城市名称/经纬度
   * scope city:表示只获取城市的空气质量信息，不包含监测站信息
   *       all:包含监测站信息
   *       
   */
  Future<AirResultListEntity> doAirInfo(String location, {String scope}) async {
    Map<String, dynamic> params = HashMap();
    params["location"] = location ?? "beijing";
    params["scope"] == scope ?? "city";
    Map<String, dynamic> map =
        await getResponse(HttpContant.AIR_INFO_PATH, params);
     map.forEach((key,value){
      print("空气质量信息：${key} : ${value}");
    });
    AirResultListEntity entity = AirResultListEntity.fromJson(map);
    if (entity.success) {
      //数据请求成功,这里需要继续对比，如果请求到的数据列表不为空则认为数据完全成功，否则认为数据
      if (entity.results == null || entity.results.isEmpty) {
        setDataEmptyError(entity);
      }
    }
    return entity;
  }

  //请求未来24小时的天气信息
  /**
   * location:要查询的位置信息：城市名/经纬度(latitude:longitude)
   * start:起始位置：0表示从当前时间开始 1表示从下个小时开始
   */
  Future<FutureHourlyWeatherResultsEntity> doFutureHourly(String location,
      {int start}) async {
    Map<String, dynamic> params = HashMap();
    params["location"] = location ?? "beijing";
    if (start != null) params["start"] = start;

    Map<String, dynamic> map =
        await getResponse(HttpContant.FUTURE_HOURLY_PATH, params);
    FutureHourlyWeatherResultsEntity entity =
        FutureHourlyWeatherResultsEntity.fromJson(map);
    if (entity.success) {
      //数据请求成功,这里需要继续对比，如果请求到的数据列表不为空则认为数据完全成功，否则认为数据
      if (entity.results == null || entity.results.isEmpty) {
        setDataEmptyError(entity);
      }
    }
    return entity;
  }

  //请求未来5天的天气情况
  /**
   * location:位置信息
   * days:请求的天数，默认为5天
   */
  Future<FutureDaysWeatherResultsEntity> doFutureDailyWeather(String location,
      {int days = 5}) async {
    Map<String, dynamic> params = HashMap();
    params["location"] = location ?? "beijing";
    params["days"] = 5;
    
    Map<String,dynamic> map =
        await getResponse(HttpContant.FUTURE_DAILY_PATH, params);
    FutureDaysWeatherResultsEntity entity = FutureDaysWeatherResultsEntity.fromJson(map);
    if (entity.success) {
      //数据请求成功,这里需要继续对比，如果请求到的数据列表不为空则认为数据完全成功，否则认为数据
      if (entity.results == null || entity.results.isEmpty) {
        setDataEmptyError(entity);
      }
    }
    return entity;
  }

  //请求生活指数信息
  /**
   * location:位置信息
   */
  Future<LifeSuggestionResultsEntity> doSuggestionInfo(String location) async {
    Map<String, dynamic> params = HashMap();
    params["location"] = location ?? "beijing";
    
    Map<String,dynamic> map =
        await getResponse(HttpContant.SUGGESTION_INFO_PATH, params);
    LifeSuggestionResultsEntity entity = LifeSuggestionResultsEntity.fromJson(map);
    if (entity.success) {
      //数据请求成功,这里需要继续对比，如果请求到的数据列表不为空则认为数据完全成功，否则认为数据
      if (entity.results == null || entity.results.isEmpty) {
        setDataEmptyError(entity);
      }
    }
    return entity;
  }

  //根据用户输入的数据请求地址信息
  Future<LocationListEntity> doSearchCity(String cityName) async {
    Map<String, dynamic> params = HashMap();
    params["q"] = cityName;
    
    Map<String,dynamic> map = await getResponse(HttpContant.CITY_SEARCH_PATH, params);
    LocationListEntity entity = LocationListEntity.fromJson(map);
    if (entity.success) {
      //数据请求成功,这里需要继续对比，如果请求到的数据列表不为空则认为数据完全成功，否则认为数据
      if (entity.results == null || entity.results.isEmpty) {
        setDataEmptyError(entity);
      }
    }
    return entity;
  }
}
