import 'package:json_annotation/json_annotation.dart';
/**
 * 未来24小时天气信息
 */

import 'package:weather_project/data/location/LocationEntity.dart';
part 'FutureHourlyWeatherInfo.g.dart';
/**
 * 每小时天气信息
 */
@JsonSerializable()
class HourlyWeatherEntity {
  String time;//时间
  String text;//天气现象文字
  String code;//天气现象代码
  String temperature;//温度
  String humidity;//相对湿度
  String wind_direction;//风向
  String wind_speed;//风速
  
  HourlyWeatherEntity(
    this.time,
    this.text,
    this.code,
    this.temperature,
    this.humidity,
    this.wind_direction,
    this.wind_speed
  );

  factory HourlyWeatherEntity.fromJson(Map<String,dynamic> json) => _$HourlyWeatherEntityFromJson(json);
}

//位置信息和逐小时天气信息
@JsonSerializable()
class FutureHourlyWeatherEntity{
  LocationEntity location;
  List<HourlyWeatherEntity> hourly;

  FutureHourlyWeatherEntity(
    this.location,
    this.hourly
  );

  factory FutureHourlyWeatherEntity.fromJson(Map<String,dynamic> json) => _$FutureHourlyWeatherEntityFromJson(json);
}

//接口返回的总数据
@JsonSerializable()
class FutureHourlyWeatherResultsEntity{
  List<FutureHourlyWeatherEntity> results;

  FutureHourlyWeatherResultsEntity(this.results);

  factory FutureHourlyWeatherResultsEntity.fromJson(Map<String,dynamic> json) => _$FutureHourlyWeatherResultsEntityFromJson(json);
}