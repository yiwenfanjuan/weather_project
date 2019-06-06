import 'package:json_annotation/json_annotation.dart';
import 'package:weather_project/data/air/AirInfo.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
part 'AirResultInfo.g.dart';
/**
 * 空气信息最终数据
 */
@JsonSerializable()
class AirResultEntity{
  
  LocationEntity location;
  AirDetailsEntity air;

  AirResultEntity(
    this.location,
    this.air,
  );

  factory AirResultEntity.fromJson(Map<String,dynamic> json) => _$AirResultEntityFromJson(json); 
} 


@JsonSerializable()
class AirResultListEntity{
  List<AirResultEntity> results;

  AirResultListEntity(this.results);

  factory AirResultListEntity.fromJson(Map<String,dynamic> json) => _$AirResultListEntityFromJson(json);
}