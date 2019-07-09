import 'package:json_annotation/json_annotation.dart';
import 'package:weather_project/data/BaseData.dart';
part 'LocationEntity.g.dart';
/**
 * 地区数据
 */
@JsonSerializable()
class LocationEntity{
  String id;
  //地理位置名称，存储城市名或者经纬度信息：latitude:logitude
  String name;
  String country;
  String path;
  String timezone;
  String timezone_offset;

  //数据库中需要的信息
  //id
  int columnId;
  

  LocationEntity(this.id,this.name,this.country,this.path,this.timezone,this.timezone_offset);

  factory LocationEntity.fromJson(Map<String,dynamic> json) => _$LocationEntityFromJson(json);

  //根据数据库返回的信息设置数据
  LocationEntity.fromDatabase(Map<String,dynamic> databaseMap)
    : this.columnId = databaseMap["columnId"],
      this.name = databaseMap["name"],
      this.path = databaseMap["path"];

  @override
  String toString() {
    StringBuffer buffer = StringBuffer("城市信息：");
    buffer.writeln(name);
    buffer.writeln(path);
    return buffer.toString();
  }
}

//地区数据列表

@JsonSerializable()
class LocationListEntity extends BaseData{
  List<LocationEntity> results;

  LocationListEntity(this.results);

  factory LocationListEntity.fromJson(Map<String,dynamic> json) => _$LocationListEntityFromJson(json);
  
}