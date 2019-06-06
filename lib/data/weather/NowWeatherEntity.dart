import 'dart:core' as prefix0;
import 'dart:core';

import 'package:flutter/rendering.dart';
import 'package:weather_project/data/BaseData.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'NowWeatherEntity.g.dart';

/**
 * 实时天气预报
 */
@JsonSerializable()
class NowWeatherDetailsEntity {
  //定义一些颜色常量，根据晴天，阴天两种状态设置不同的背景颜色

  //晴天
  static const Color SUNNY_START_COLOR = Color(0x802196F3);
  static const Color SUNNY_END_COLOR = Color(0x80BDBDBD);

  //阴天
  static const Color OVERCAST_START_COLOR = Color(0x80546E7A);
  static const Color OVERCAST_END_COLOR = Color(0x809E9E9E);

  //天气现象文字
  String text;
  //天气现象代码
  String code;
  //温度，单位为摄氏度
  String temperature;
  //体感温度，单位为摄氏度
  String feels_like;
  //气压，单位为mb百帕
  String pressure;
  //相对湿度
  String humidity;
  //能见度
  String visibility;
  //风向文字
  String wind_direction;
  //风向角度
  String wind_direction_degree;
  //风速
  String wind_speed;
  //风力
  String wind_scale;
  //云量，中国城市不支持
  String clouds;
  //露点温度 中国城市不支持
  String dew_point;

  //根据不同的天气信息设置不同的颜色，用于天气页面的背景
  Color _bgStartColor;
  Color _bgEndColor;

  //根据不同的天气信息返回不同的图片路径
  String _weatherImagePath;

  Color get startColor =>  _bgStartColor;

  Color get endColor => _bgEndColor;

  String get imagePath => _weatherImagePath;

  NowWeatherDetailsEntity(
      this.text,
      this.code,
      this.temperature,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.visibility,
      this.wind_direction,
      this.wind_direction_degree,
      this.wind_speed,
      this.wind_scale,
      this.clouds,
      this.dew_point);

  factory NowWeatherDetailsEntity.fromJson(Map<String, dynamic> json) {
    NowWeatherDetailsEntity entity = _$NowWeatherDetailsEntityFromJson(json);
    entity.initColorAndImage(entity, json);
    return entity;
  }

  void initColorAndImage(
      NowWeatherDetailsEntity entity, Map<String, dynamic> json) {
    switch (json["code"]) {
      case "0":
      case "2":
        //白天晴天
        _weatherImagePath = "icons/icon_sunny_day.png";
        break;
      case "1":
      case "3":
        //夜间白天
        _weatherImagePath = "icons/icon_sunny_night.png";
        break;

      case "4":
        //多云
        _weatherImagePath = "icons/icon_cloudy.png";
        break;

      case "5":
        //白天晴间多云
        _weatherImagePath = "icons/icon_partly_cloudy_day.png";
        break;

      case "6":
        //晚上晴间多云
        _weatherImagePath = "icons/icon_partly_cloudy_night.png";
        break;
      case "7":
        //白天大部多云
        _weatherImagePath = "icons/icon_mostly_cloudy_day.png";
        break;
      case "8":
        //晚上大部多云
        _weatherImagePath = "icons/icon_mostly_cloudy_night.png";
        break;
      case "9":
        //阴
        _weatherImagePath = "icons/icon_overcast.png";
        break;
      case "10":
        //阵雨
        _weatherImagePath = "icons/icon_shower.png";
        break;
      case "11":
        //雷阵雨
        _weatherImagePath = "icons/icon_thundershower.png";
        break;
      case "12":
        //雷阵雨伴有冰雹
        _weatherImagePath = "icons/icon_thundershower_with_hail.png";
        break;
      case "13":
        //小雨
        _weatherImagePath = "icons/icon_light_rain.png";
        break;
      case "14":
        //中雨
        _weatherImagePath = "icons/icon_moderate_rain.png";
        break;
      case "15":
        //大雨
        _weatherImagePath = "icons/icon_heavy_rain.png";
        break;
      case "16":
        //暴雨
        _weatherImagePath = "icons/icon_storm.png";
        break;
      case "17":
        //大暴雨
        _weatherImagePath = "icons/icon_heavy_storm.png";
        break;
      case "18":
        //特大暴雨
        _weatherImagePath = "icons/icon_severe_storm.png";
        break;
      case "19":
        //冻雨
        _weatherImagePath = "icons/icon_ice_rain.png";
        break;
      case "20":
        //雨夹雪
        _weatherImagePath = "icons/icon_sleet.png";
        break;
      case "21":
        //阵雪
        _weatherImagePath = "icons/icon_snow_flurry.png";
        break;
      case "22":
        //小雪
        _weatherImagePath = "icons/icon_light_snow.png";
        break;
      case "23":
        //中雪
        _weatherImagePath = "icons/icon_moderate_snow.png";
        break;
      case "24":
        //大雪
        _weatherImagePath = "icons/icon_heavy_snow.png";
        break;
      case "25":
        //暴雪
        _weatherImagePath = "icons/icon_snowstorm.png";
        break;
      case "26":
        //浮尘
        _weatherImagePath = "icons/icon_dust.png";
        break;
      case "27":
        //扬沙
        _weatherImagePath = "icons/icon_sand.png";
        break;
      case "28":
        //沙尘暴
        _weatherImagePath = "icons/icon_duststorm.png";
        break;
      case "29":
        //强沙尘暴
        _weatherImagePath = "icons/icon_sandstorm.png";
        break;
      case "30":
        //雾
        _weatherImagePath = "icons/icon_foggy.png";
        break;
      case "31":
        //霾
        _weatherImagePath = "icons/icon_haze.png";
        break;
      case "32":
        //风
        _weatherImagePath = "icons/icon_windy.png";
        break;

      case "33":
        //大风
        _weatherImagePath = "icons/icon_blustery.png";
        break;
      case "34":
        //飓风
        _weatherImagePath = "icons/icon_hurricane.png";
        break;

      case "35":
        //热带风暴
        _weatherImagePath = "icons/icon_tropical_storm.png";
        break;

      case "36":
        //龙卷风
        _weatherImagePath = "icons/icon_tornado.png";
        break;

      case "37":
        //冷
        _weatherImagePath = "icons/icon_cold.png";
        break;

      case "38":
        //热
        _weatherImagePath = "icons/icon_hot.png";
        break;

      case "99":
        //未知天气类型
        _weatherImagePath = "icons/icon_unknown.png";
        break;
    }

    if (int.parse(json["code"],onError: (source){print("数据转换出错$source"); return 0;}) > 8) {
      _bgStartColor = OVERCAST_START_COLOR;
      _bgEndColor = OVERCAST_END_COLOR;
    } else {
      _bgStartColor = SUNNY_START_COLOR;
      _bgEndColor = SUNNY_END_COLOR;
    }
  }
}

@JsonSerializable()
class NowWeatherEntity {
  LocationEntity location;
  NowWeatherDetailsEntity now;
  String last_update;

  NowWeatherEntity(this.location, this.now, this.last_update);

  factory NowWeatherEntity.fromJson(Map<String, dynamic> json) =>
      _$NowWeatherEntityFromJson(json);
}

//天气信息列表
@JsonSerializable()
class NowWeatherListEntity extends BaseData{

  List<NowWeatherEntity> results;

  NowWeatherListEntity(this.results);

  factory NowWeatherListEntity.fromJson(Map<String, dynamic> json) =>
      _$NowWeatherListEntityFromJson(json);
}
