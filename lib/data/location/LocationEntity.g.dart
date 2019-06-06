// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LocationEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationEntity _$LocationEntityFromJson(Map<String, dynamic> json) {
  return LocationEntity(
      json['id'] as String,
      json['name'] as String,
      json['country'] as String,
      json['path'] as String,
      json['timezone'] as String,
      json['timezone_offset'] as String)
    ..columnId = json['columnId'] as int;
}

Map<String, dynamic> _$LocationEntityToJson(LocationEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'country': instance.country,
      'path': instance.path,
      'timezone': instance.timezone,
      'timezone_offset': instance.timezone_offset,
      'columnId': instance.columnId
    };

LocationListEntity _$LocationListEntityFromJson(Map<String, dynamic> json) {
  return LocationListEntity((json['results'] as List)
      ?.map((e) =>
          e == null ? null : LocationEntity.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$LocationListEntityToJson(LocationListEntity instance) =>
    <String, dynamic>{'results': instance.results};
