// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FutureDailyWeatherInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DailyWeatherEntity _$DailyWeatherEntityFromJson(Map<String, dynamic> json) {
  return DailyWeatherEntity(
      json['date'] as String,
      json['text_day'] as String,
      json['code_day'] as String,
      json['text_night'] as String,
      json['code_night'] as String,
      json['high'] as String,
      json['low'] as String,
      json['precip'] as String,
      json['wind_direction'] as String,
      json['wind_direction_degree'] as String,
      json['wind_speed'] as String,
      json['wind_scale'] as String);
}

Map<String, dynamic> _$DailyWeatherEntityToJson(DailyWeatherEntity instance) =>
    <String, dynamic>{
      'date': instance.date,
      'text_day': instance.text_day,
      'code_day': instance.code_day,
      'text_night': instance.text_night,
      'code_night': instance.code_night,
      'high': instance.high,
      'low': instance.low,
      'precip': instance.precip,
      'wind_direction': instance.wind_direction,
      'wind_direction_degree': instance.wind_direction_degree,
      'wind_speed': instance.wind_speed,
      'wind_scale': instance.wind_scale
    };

FutureDaysWeatherEntity _$FutureDaysWeatherEntityFromJson(
    Map<String, dynamic> json) {
  return FutureDaysWeatherEntity(
      json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      (json['daily'] as List)
          ?.map((e) => e == null
              ? null
              : DailyWeatherEntity.fromJson(e as Map<String, dynamic>))
          ?.toList());
}

Map<String, dynamic> _$FutureDaysWeatherEntityToJson(
        FutureDaysWeatherEntity instance) =>
    <String, dynamic>{'location': instance.location, 'daily': instance.daily};

FutureDaysWeatherResultsEntity _$FutureDaysWeatherResultsEntityFromJson(
    Map<String, dynamic> json) {
  return FutureDaysWeatherResultsEntity((json['results'] as List)
      ?.map((e) => e == null
          ? null
          : FutureDaysWeatherEntity.fromJson(e as Map<String, dynamic>))
      ?.toList())
    ..status = json['status'] as String
    ..status_code = json['status_code'] as int
    ..message = json['message'] as String
    ..code = json['code'] as int
    ..success = json['success'] as bool
    ..data = json['data'] as Map<String, dynamic>;
}

Map<String, dynamic> _$FutureDaysWeatherResultsEntityToJson(
        FutureDaysWeatherResultsEntity instance) =>
    <String, dynamic>{
      'status': instance.status,
      'status_code': instance.status_code,
      'message': instance.message,
      'code': instance.code,
      'success': instance.success,
      'data': instance.data,
      'results': instance.results
    };
