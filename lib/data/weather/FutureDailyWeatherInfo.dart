import 'package:json_annotation/json_annotation.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
part 'FutureDailyWeatherInfo.g.dart';
/**
 * 未来5天天气状况数据
 */
@JsonSerializable()
class DailyWeatherEntity {
  String date;
  String text_day;
  String code_day;
  String text_night;
  String code_night;
  String high;
  String low;
  String precip;
  String wind_direction;
  String wind_direction_degree;
  String wind_speed;
  String wind_scale;

  DailyWeatherEntity(
    this.date,
    this.text_day,
    this.code_day,
    this.text_night,
    this.code_night,
    this.high,
    this.low,
    this.precip,
    this.wind_direction,
    this.wind_direction_degree,
    this.wind_speed,
    this.wind_scale,
  );

  factory DailyWeatherEntity.fromJson(Map<String,dynamic> json) => _$DailyWeatherEntityFromJson(json);
}

//位置信息和日期天气列表
@JsonSerializable()
class FutureDaysWeatherEntity{
  LocationEntity location;
  List<DailyWeatherEntity> daily;

  FutureDaysWeatherEntity(
    this.location,
    this.daily,
  );

  factory FutureDaysWeatherEntity.fromJson(Map<String,dynamic> json) => _$FutureDaysWeatherEntityFromJson(json);
}

//总数据
@JsonSerializable()
class FutureDaysWeatherResultsEntity{

  List<FutureDaysWeatherEntity> results;

  FutureDaysWeatherResultsEntity(this.results);
  factory FutureDaysWeatherResultsEntity.fromJson(Map<String,dynamic> json) => _$FutureDaysWeatherResultsEntityFromJson(json);
}