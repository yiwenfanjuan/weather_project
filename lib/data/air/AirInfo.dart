import 'package:json_annotation/json_annotation.dart';
import 'package:weather_project/data/BaseData.dart';
import 'package:weather_project/data/air/StationInfo.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
part 'AirInfo.g.dart';
/**
 * 空气信息
 */

//城市空气信息
@JsonSerializable()
class CityAirEntity{
  String aqi;//空气质量指数
  String pm25;//PM2.5一小时平均值
  String pm10;//PM10颗粒物1小时平均值
  String so2;//二氧化硫一小时平均值
  String no2;//二氧化氮一小时平均值
  String co;//一氧化碳一小时平均值
  String o3;//臭氧一小时平均值
  String primary_pollutant;//首要污染物
  String quality;//空气质量类别
  String last_update;//数据发布时间

  CityAirEntity(
    this.aqi,
    this.pm25,
    this.pm10,
    this.so2,
    this.no2,
    this.co,
    this.o3,
    this.primary_pollutant,
    this.quality,
    this.last_update,
  );

  factory CityAirEntity.fromJson(Map<String,dynamic> json) => _$CityAirEntityFromJson(json);
}

//空气信息详情
@JsonSerializable()
class AirDetailsEntity extends BaseData{

  CityAirEntity city;
  List<StationEntity> stations;

  AirDetailsEntity(
    this.city,
    this.stations,
  );

  factory AirDetailsEntity.fromJson(Map<String,dynamic> json) => _$AirDetailsEntityFromJson(json);
}

