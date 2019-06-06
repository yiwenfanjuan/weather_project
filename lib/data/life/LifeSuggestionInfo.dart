import 'package:json_annotation/json_annotation.dart';
import 'package:weather_project/data/location/LocationEntity.dart';

part 'LifeSuggestionInfo.g.dart';
/**
 * 生活指数数据
 */

@JsonSerializable()
class SuggestionEntity{
  String brief;
  String details;

  SuggestionEntity(
    this.brief,
    this.details,
  );

  factory SuggestionEntity.fromJson(Map<String,dynamic> json) => _$SuggestionEntityFromJson(json);

  @override
  String toString() {
    return "$brief : $details";
  }
}

//建议数据
@JsonSerializable()
class LifeSuggestionEntity{
  SuggestionEntity ac;
  SuggestionEntity air_pollution;
  SuggestionEntity airing;
  SuggestionEntity allergy;
  SuggestionEntity beer;
  SuggestionEntity boating;
  SuggestionEntity car_washing;
  SuggestionEntity chill;
  SuggestionEntity comfort;
  SuggestionEntity dating;
  SuggestionEntity dressing;
  SuggestionEntity fishing;
  SuggestionEntity flu;
  SuggestionEntity hair_dressing;
  SuggestionEntity kiteflying;
  SuggestionEntity makeup;
  SuggestionEntity mood;
  SuggestionEntity morning_sport;
  SuggestionEntity night_life;
  SuggestionEntity road_condition;
  SuggestionEntity shopping;
  SuggestionEntity sunscreen;
  SuggestionEntity traffic;
  SuggestionEntity travel;
  SuggestionEntity umbrella;
  SuggestionEntity sport;
  SuggestionEntity uv;

  LifeSuggestionEntity(
    this.ac,
    this.air_pollution,
    this.airing,
    this.allergy,
    this.beer,
    this.boating,
    this.car_washing,
    this.chill,
    this.comfort,
    this.dating,
    this.dressing,
    this.fishing,
    this.flu,
    this.hair_dressing,
    this.kiteflying,
    this.umbrella,
    this.travel,
    this.traffic,
    this.sunscreen,
    this.shopping,
    this.road_condition,
    this.night_life,
    this.morning_sport,
    this.mood,
    this.makeup,
    this.sport,
    this.uv,
  );

  factory LifeSuggestionEntity.fromJson(Map<String,dynamic> json) => _$LifeSuggestionEntityFromJson(json);

  @override
  String toString() {
    return "生活指数信息：${ac.toString()} \n ${uv.toString()}";
  }
}

@JsonSerializable()
class LifeSuggesstionLocationEntity{

  LocationEntity location;
  LifeSuggestionEntity suggestion;

  LifeSuggesstionLocationEntity(
    this.location,
    this.suggestion,
  );

  factory LifeSuggesstionLocationEntity.fromJson(Map<String,dynamic> json) => _$LifeSuggesstionLocationEntityFromJson(json);
}

@JsonSerializable()
class LifeSuggestionResultsEntity{
  List<LifeSuggesstionLocationEntity> results;

  LifeSuggestionResultsEntity(this.results);

  factory LifeSuggestionResultsEntity.fromJson(Map<String,dynamic> json) => _$LifeSuggestionResultsEntityFromJson(json);
}