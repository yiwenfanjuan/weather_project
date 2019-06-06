// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AirInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CityAirEntity _$CityAirEntityFromJson(Map<String, dynamic> json) {
  return CityAirEntity(
      json['aqi'] as String,
      json['pm25'] as String,
      json['pm10'] as String,
      json['so2'] as String,
      json['no2'] as String,
      json['co'] as String,
      json['o3'] as String,
      json['primary_pollutant'] as String,
      json['quality'] as String,
      json['last_update'] as String);
}

Map<String, dynamic> _$CityAirEntityToJson(CityAirEntity instance) =>
    <String, dynamic>{
      'aqi': instance.aqi,
      'pm25': instance.pm25,
      'pm10': instance.pm10,
      'so2': instance.so2,
      'no2': instance.no2,
      'co': instance.co,
      'o3': instance.o3,
      'primary_pollutant': instance.primary_pollutant,
      'quality': instance.quality,
      'last_update': instance.last_update
    };

AirDetailsEntity _$AirDetailsEntityFromJson(Map<String, dynamic> json) {
  return AirDetailsEntity(
      json['city'] == null
          ? null
          : CityAirEntity.fromJson(json['city'] as Map<String, dynamic>),
      (json['stations'] as List)
          ?.map((e) => e == null
              ? null
              : StationEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$AirDetailsEntityToJson(AirDetailsEntity instance) =>
    <String, dynamic>{'city': instance.city, 'stations': instance.stations};
