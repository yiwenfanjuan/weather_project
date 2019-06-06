// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'LifeSuggestionInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SuggestionEntity _$SuggestionEntityFromJson(Map<String, dynamic> json) {
  return SuggestionEntity(json['brief'] as String, json['details'] as String);
}

Map<String, dynamic> _$SuggestionEntityToJson(SuggestionEntity instance) =>
    <String, dynamic>{'brief': instance.brief, 'details': instance.details};

LifeSuggestionEntity _$LifeSuggestionEntityFromJson(Map<String, dynamic> json) {
  return LifeSuggestionEntity(
      json['ac'] == null
          ? null
          : SuggestionEntity.fromJson(json['ac'] as Map<String, dynamic>),
      json['air_pollution'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['air_pollution'] as Map<String, dynamic>),
      json['airing'] == null
          ? null
          : SuggestionEntity.fromJson(json['airing'] as Map<String, dynamic>),
      json['allergy'] == null
          ? null
          : SuggestionEntity.fromJson(json['allergy'] as Map<String, dynamic>),
      json['beer'] == null
          ? null
          : SuggestionEntity.fromJson(json['beer'] as Map<String, dynamic>),
      json['boating'] == null
          ? null
          : SuggestionEntity.fromJson(json['boating'] as Map<String, dynamic>),
      json['car_washing'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['car_washing'] as Map<String, dynamic>),
      json['chill'] == null
          ? null
          : SuggestionEntity.fromJson(json['chill'] as Map<String, dynamic>),
      json['comfort'] == null
          ? null
          : SuggestionEntity.fromJson(json['comfort'] as Map<String, dynamic>),
      json['dating'] == null
          ? null
          : SuggestionEntity.fromJson(json['dating'] as Map<String, dynamic>),
      json['dressing'] == null
          ? null
          : SuggestionEntity.fromJson(json['dressing'] as Map<String, dynamic>),
      json['fishing'] == null
          ? null
          : SuggestionEntity.fromJson(json['fishing'] as Map<String, dynamic>),
      json['flu'] == null
          ? null
          : SuggestionEntity.fromJson(json['flu'] as Map<String, dynamic>),
      json['hair_dressing'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['hair_dressing'] as Map<String, dynamic>),
      json['kiteflying'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['kiteflying'] as Map<String, dynamic>),
      json['umbrella'] == null
          ? null
          : SuggestionEntity.fromJson(json['umbrella'] as Map<String, dynamic>),
      json['travel'] == null
          ? null
          : SuggestionEntity.fromJson(json['travel'] as Map<String, dynamic>),
      json['traffic'] == null
          ? null
          : SuggestionEntity.fromJson(json['traffic'] as Map<String, dynamic>),
      json['sunscreen'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['sunscreen'] as Map<String, dynamic>),
      json['shopping'] == null
          ? null
          : SuggestionEntity.fromJson(json['shopping'] as Map<String, dynamic>),
      json['road_condition'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['road_condition'] as Map<String, dynamic>),
      json['night_life'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['night_life'] as Map<String, dynamic>),
      json['morning_sport'] == null
          ? null
          : SuggestionEntity.fromJson(
              json['morning_sport'] as Map<String, dynamic>),
      json['mood'] == null
          ? null
          : SuggestionEntity.fromJson(json['mood'] as Map<String, dynamic>),
      json['makeup'] == null
          ? null
          : SuggestionEntity.fromJson(json['makeup'] as Map<String, dynamic>),
      json['sport'] == null
          ? null
          : SuggestionEntity.fromJson(json['sport'] as Map<String, dynamic>),
      json['uv'] == null
          ? null
          : SuggestionEntity.fromJson(json['uv'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LifeSuggestionEntityToJson(
        LifeSuggestionEntity instance) =>
    <String, dynamic>{
      'ac': instance.ac,
      'air_pollution': instance.air_pollution,
      'airing': instance.airing,
      'allergy': instance.allergy,
      'beer': instance.beer,
      'boating': instance.boating,
      'car_washing': instance.car_washing,
      'chill': instance.chill,
      'comfort': instance.comfort,
      'dating': instance.dating,
      'dressing': instance.dressing,
      'fishing': instance.fishing,
      'flu': instance.flu,
      'hair_dressing': instance.hair_dressing,
      'kiteflying': instance.kiteflying,
      'makeup': instance.makeup,
      'mood': instance.mood,
      'morning_sport': instance.morning_sport,
      'night_life': instance.night_life,
      'road_condition': instance.road_condition,
      'shopping': instance.shopping,
      'sunscreen': instance.sunscreen,
      'traffic': instance.traffic,
      'travel': instance.travel,
      'umbrella': instance.umbrella,
      'sport': instance.sport,
      'uv': instance.uv
    };

LifeSuggesstionLocationEntity _$LifeSuggesstionLocationEntityFromJson(
    Map<String, dynamic> json) {
  return LifeSuggesstionLocationEntity(
      json['location'] == null
          ? null
          : LocationEntity.fromJson(json['location'] as Map<String, dynamic>),
      json['suggestion'] == null
          ? null
          : LifeSuggestionEntity.fromJson(
              json['suggestion'] as Map<String, dynamic>));
}

Map<String, dynamic> _$LifeSuggesstionLocationEntityToJson(
        LifeSuggesstionLocationEntity instance) =>
    <String, dynamic>{
      'location': instance.location,
      'suggestion': instance.suggestion
    };

LifeSuggestionResultsEntity _$LifeSuggestionResultsEntityFromJson(
    Map<String, dynamic> json) {
  return LifeSuggestionResultsEntity((json['results'] as List)
      ?.map((e) => e == null
          ? null
          : LifeSuggesstionLocationEntity.fromJson(e as Map<String, dynamic>))
      ?.toList());
}

Map<String, dynamic> _$LifeSuggestionResultsEntityToJson(
        LifeSuggestionResultsEntity instance) =>
    <String, dynamic>{'results': instance.results};
