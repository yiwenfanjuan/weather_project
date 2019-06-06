import 'dart:convert';
import 'package:weather_project/data/BaseData.dart';

class BasePageData<D > extends BaseData<D> {

  List<D> results;

  BasePageData();

  BasePageData.fromJson(Map<String, dynamic> map) : super.fromJson(map) {
    print("results需要转换的数据类型：${D.runtimeType}");
    var resultsList = map["results"] as List;
    results = resultsList.map((item) {
    
    }).toList();
  }


}