// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AirResultInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AirResultEntity _$AirResultEntityFromJson(Map<String, dynamic> json) {
  return AirResultEntity(
      json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      json['air'] == null
          ? null
          : AirDetailsEntity.fromJson(json['air'] as Map<String, dynamic>));
}

Map<String, dynamic> _$AirResultEntityToJson(AirResultEntity instance) =>
    <String, dynamic>{'location': instance.location, 'air': instance.air};

AirResultListEntity _$AirResultListEntityFromJson(Map<String, dynamic> json) {
  return AirResultListEntity((json['results'] as List)
      ?.map((e) => e == null
          ? null
          : AirResultEntity.fromJson(e as Map<String, dynamic>))
      ?.toList())
    ..status = json['status'] as String
    ..status_code = json['status_code'] as int
    ..message = json['message'] as String
    ..code = json['code'] as int
    ..success = json['success'] as bool
    ..data = json['data'] as Map<String, dynamic>;
}

Map<String, dynamic> _$AirResultListEntityToJson(
        AirResultListEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.status_code,
      'message': instance.message,
      'code': instance.code,
      'success': instance.success,
      'data': instance.data,
      'results': instance.results
    };
