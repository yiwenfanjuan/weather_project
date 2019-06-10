// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'NowWeatherEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NowWeatherDetailsEntity _$NowWeatherDetailsEntityFromJson(
    Map<String, dynamic> json) {
  return NowWeatherDetailsEntity(
      json['text'] as String,
      json['code'] as String,
      json['temperature'] as String,
      json['feels_like'] as String,
      json['pressure'] as String,
      json['humidity'] as String,
      json['visibility'] as String,
      json['wind_direction'] as String,
      json['wind_direction_degree'] as String,
      json['wind_speed'] as String,
      json['wind_scale'] as String,
      json['clouds'] as String,
      json['dew_point'] as String);
}

Map<String, dynamic> _$NowWeatherDetailsEntityToJson(
        NowWeatherDetailsEntity instance) =>
    <String, dynamic>{
      'text': instance.text,
      'code': instance.code,
      'temperature': instance.temperature,
      'feels_like': instance.feels_like,
      'pressure': instance.pressure,
      'humidity': instance.humidity,
      'visibility': instance.visibility,
      'wind_direction': instance.wind_direction,
      'wind_direction_degree': instance.wind_direction_degree,
      'wind_speed': instance.wind_speed,
      'wind_scale': instance.wind_scale,
      'clouds': instance.clouds,
      'dew_point': instance.dew_point
    };

NowWeatherEntity _$NowWeatherEntityFromJson(Map<String, dynamic> json) {
  return NowWeatherEntity(
      json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      json['now'] == null
          ? null
          : NowWeatherDetailsEntity.fromJson(
              json['now'] as Map<String, dynamic>),
      json['last_update'] as String);
}

Map<String, dynamic> _$NowWeatherEntityToJson(NowWeatherEntity instance) =>
    <String, dynamic>{
      'location': instance.location,
      'now': instance.now,
      'last_update': instance.last_update
    };

NowWeatherListEntity _$NowWeatherListEntityFromJson(Map<String, dynamic> json) {
  return NowWeatherListEntity((json['results'] as List)
      ?.map((e) => e == null
          ? null
          : NowWeatherEntity.fromJson(e as Map<String, dynamic>))
      ?.toList())
    ..status = json['status'] as String
    ..status_code = json['status_code'] as int
    ..message = json['message'] as String
    ..code = json['code'] as int
    ..success = json['success'] as bool
    ..data = json['data'] as Map<String, dynamic>;
}

Map<String, dynamic> _$NowWeatherListEntityToJson(
        NowWeatherListEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.status_code,
      'message': instance.message,
      'code': instance.code,
      'success': instance.success,
      'data': instance.data,
      'results': instance.results
    };
