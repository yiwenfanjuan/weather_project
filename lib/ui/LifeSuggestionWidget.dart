import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/data/life/LifeSuggestionInfo.dart';
import 'package:weather_project/utils/WeatherUtils.dart';

/**
 * 生活指数信息
 */

class LifeSuggestionListWidget extends StatelessWidget{
  //生活指数信息
  final LifeSuggestionEntity _entity;

  LifeSuggestionListWidget(this._entity);
  @override
  Widget build(BuildContext context) {
    //分成左右两列
    return _entity == null ? null : Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        //左边
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              //紫外线
              _LifeSuggestionWidget(_entity.uv, "uv"),
              //舒适度
              _LifeSuggestionWidget(_entity.comfort, "comfort"),
              //感冒
              _LifeSuggestionWidget(_entity.flu, "flu"),
            ],
          ),
        ),

        //右边
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              //防晒
              _LifeSuggestionWidget(_entity.sunscreen, "sunscreen"),
              //空调建议
              _LifeSuggestionWidget(_entity.ac, "ac"),
              //运动建议
              _LifeSuggestionWidget(_entity.sport, "sport"),
            ],
          ),
        ),
      ],
    );
  }
}



class _LifeSuggestionWidget extends StatelessWidget{

  final SuggestionEntity _suggestionEntity;
  final String _type;
  _LifeSuggestionWidget(this._suggestionEntity,this._type);
  @override
  Widget build(BuildContext context) {
    return  Container(
        constraints: BoxConstraints.expand(height: 120.0),
        child: _suggestionEntity == null ? null : Center(
          child: Padding(
            padding: EdgeInsets.only(top: 10.0,left: 15.0),
            child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //生活指数类型
              Text(WeatherUtils.getSuggestionText(_type),
                style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                ),
              ),
              //简要信息
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(_suggestionEntity.brief,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              //简要信息
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text(_suggestionEntity.details,
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.grey,
                  ),
                  maxLines: 2,
                ),
              ),
            ],
          ),
          ),
        ),
    );
  }
}