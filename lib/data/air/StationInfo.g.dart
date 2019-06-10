// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StationInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StationEntity _$StationEntityFromJson(Map<String, dynamic> json) {
  return StationEntity(
      json['aqi'] as String,
      json['pm25'] as String,
      json['pm10'] as String,
      json['so2'] as String,
      json['no2'] as String,
      json['co'] as String,
      json['o3'] as String,
      json['primary_pollutant'] as String,
      json['station'] as String,
      json['latitude'] as String,
      json['longitude'] as String,
      json['last_update'] as String);
}

Map<String, dynamic> _$StationEntityToJson(StationEntity instance) =>
    <String, dynamic>{
      'aqi': instance.aqi,
      'pm25': instance.pm25,
      'pm10': instance.pm10,
      'so2': instance.so2,
      'no2': instance.no2,
      'co': instance.co,
      'o3': instance.o3,
      'primary_pollutant': instance.primary_pollutant,
      'station': instance.station,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'last_update': instance.last_update
    };

StationListEntity _$StationListEntityFromJson(Map<String, dynamic> json) {
  return StationListEntity((json['stations'] as List)
      ?.map((e) =>
          e == null ? null : StationEntity.fromJson(e as Map<String, dynamic>))
      ?.toList())
    ..status = json['status'] as String
    ..status_code = json['status_code'] as int
    ..message = json['message'] as String
    ..code = json['code'] as int
    ..success = json['success'] as bool
    ..data = json['data'] as Map<String, dynamic>;
}

Map<String, dynamic> _$StationListEntityToJson(StationListEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.status_code,
      'message': instance.message,
      'code': instance.code,
      'success': instance.success,
      'data': instance.data,
      'stations': instance.stations
    };
