// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FutureHourlyWeatherInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HourlyWeatherEntity _$HourlyWeatherEntityFromJson(Map<String, dynamic> json) {
  return HourlyWeatherEntity(
      json['time'] as String,
      json['text'] as String,
      json['code'] as String,
      json['temperature'] as String,
      json['humidity'] as String,
      json['wind_direction'] as String,
      json['wind_speed'] as String);
}

Map<String, dynamic> _$HourlyWeatherEntityToJson(
        HourlyWeatherEntity instance) =>
    <String, dynamic>{
      'time': instance.time,
      'text': instance.text,
      'code': instance.code,
      'temperature': instance.temperature,
      'humidity': instance.humidity,
      'wind_direction': instance.wind_direction,
      'wind_speed': instance.wind_speed
    };

FutureHourlyWeatherEntity _$FutureHourlyWeatherEntityFromJson(
    Map<String, dynamic> json) {
  return FutureHourlyWeatherEntity(
      json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      (json['hourly'] as List)
          ?.map((e) => e == null
              ? null
              : HourlyWeatherEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FutureHourlyWeatherEntityToJson(
        FutureHourlyWeatherEntity instance) =>
    <String, dynamic>{'location': instance.location, 'hourly': instance.hourly};

FutureHourlyWeatherResultsEntity _$FutureHourlyWeatherResultsEntityFromJson(
    Map<String, dynamic> json) {
  return FutureHourlyWeatherResultsEntity((json['results'] as List)
      ?.map((e) => e == null
          ? null
          : FutureHourlyWeatherEntity.fromJson(e as Map<String, dynamic>))
      ?.toList())
    ..status = json['status'] as String
    ..status_code = json['status_code'] as int
    ..message = json['message'] as String
    ..code = json['code'] as int
    ..success = json['success'] as bool
    ..data = json['data'] as Map<String, dynamic>;
}

Map<String, dynamic> _$FutureHourlyWeatherResultsEntityToJson(
        FutureHourlyWeatherResultsEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.status_code,
      'message': instance.message,
      'code': instance.code,
      'success': instance.success,
      'data': instance.data,
      'results': instance.results
    };
