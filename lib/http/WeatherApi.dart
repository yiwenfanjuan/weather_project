import 'dart:async';
import 'dart:async' as prefix0;
import 'dart:collection';
import 'dart:core';
import 'package:dio/dio.dart';
import 'package:weather_project/data/air/AirResultInfo.dart';
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
  Future<Response> getResponse(String path, Map<String, dynamic> params) async {
    Dio dio = HttpClient.getDio();
    params["key"] = "SDC2_EKz3UhUF-HpU";
    Response response = await dio.get(path, queryParameters: params);
    print(
        "$path 请求到的数据: ${response.statusCode} \n ${response.headers.toString()} \n ${response.data}}");
    return response;
  }

//获取当前所在地区的天气实况
  Future<NowWeatherListEntity> doNowWeather(String cityName) async {
    Map<String, dynamic> params = HashMap();
    params["location"] = cityName ?? "beijing";
    Response response = await getResponse(HttpContant.NOW_WEATHER_PATH, params);
    NowWeatherListEntity entity = null;
    if (response.statusCode == HttpContant.HTTP_SUCCESS &&
        response.data is Map) {
      Map<String, dynamic> data = response.data;
      //解析数据
      if (data.containsKey("results")) {
        entity = NowWeatherListEntity.fromJson(data);
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
    AirResultListEntity entity = null;
    Response response = await getResponse(HttpContant.AIR_INFO_PATH, params);
    if (response.statusCode == HttpContant.HTTP_SUCCESS &&
        response.data is Map) {
      Map<String, dynamic> data = response.data;
      if (data.containsKey("results")) {
        entity = AirResultListEntity.fromJson(data);
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
    FutureHourlyWeatherResultsEntity entity = null;
    Response response =
        await getResponse(HttpContant.FUTURE_HOURLY_PATH, params);
    if (response.statusCode == HttpContant.HTTP_SUCCESS &&
        response.data is Map) {
      Map<String, dynamic> map = response.data;
      if (map.containsKey("results")) {
        entity = FutureHourlyWeatherResultsEntity.fromJson(map);
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
    FutureDaysWeatherResultsEntity entity = null;
    Response response =
        await getResponse(HttpContant.FUTURE_DAILY_PATH, params);
    if (response.statusCode == HttpContant.HTTP_SUCCESS &&
        response.data is Map) {
      Map<String, dynamic> map = response.data;
      if (map.containsKey("results")) {
        entity = FutureDaysWeatherResultsEntity.fromJson(map);
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
    LifeSuggestionResultsEntity entity;
    Response response =
        await getResponse(HttpContant.SUGGESTION_INFO_PATH, params);
    if (response.statusCode == HttpContant.HTTP_SUCCESS &&
        response.data is Map) {
      Map<String, dynamic> map = response.data;
      if (map.containsKey("results")) {
        entity = LifeSuggestionResultsEntity.fromJson(map);
      }
    }
    return entity;
  }

  //根据用户输入的数据请求地址信息
  Future<LocationListEntity> doSearchCity(String cityName) async {
    Map<String, dynamic> params = HashMap();
    params["q"] = cityName;
    LocationListEntity entity;
    Response response = await getResponse(HttpContant.CITY_SEARCH_PATH, params);
    if (response.statusCode == HttpContant.HTTP_SUCCESS &&
        response.data is Map) {
      Map<String, dynamic> map = response.data;
      if (map.containsKey("results")) {
        entity = LocationListEntity.fromJson(map);
      }
    }
    return entity;
  }
}
