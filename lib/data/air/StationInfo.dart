import 'package:json_annotation/json_annotation.dart';
import 'package:weather_project/data/BaseData.dart';
part 'StationInfo.g.dart';

/**
 * 监测站信息
 */

@JsonSerializable()
class StationEntity{

  String aqi;
  String pm25;
  String pm10;
  String so2;
  String no2;
  String co;
  String o3;
  String primary_pollutant;
  String station;
  String latitude;
  String longitude;
  String last_update;

  StationEntity(
    this.aqi,
    this.pm25,
    this.pm10,
    this.so2,
    this.no2,
    this.co,
    this.o3,
    this.primary_pollutant,
    this.station,
    this.latitude,
    this.longitude,
    this.last_update,
  );

  
  //创建工厂构造函数
  factory StationEntity.fromJson(Map<String,dynamic> json) =>  _$StationEntityFromJson(json);
}

//监测站列表
@JsonSerializable()
class StationListEntity extends BaseData{
  List<StationEntity> stations;
  StationListEntity(
    this.stations,
  );
  factory StationListEntity.fromJson(Map<String,dynamic> json) => _$StationListEntityFromJson(json);
}