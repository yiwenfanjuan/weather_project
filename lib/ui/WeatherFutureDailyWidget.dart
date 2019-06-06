import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/data/weather/FutureDailyWeatherInfo.dart';
import 'package:weather_project/utils/DateUtils.dart';
import 'package:weather_project/utils/WeatherUtils.dart';

/**
 * 5天天气状况预测
 */

class WeatherFutureDailyWidget extends StatefulWidget {
  final FutureDaysWeatherEntity _daysWeatherEntity;

  WeatherFutureDailyWidget(this._daysWeatherEntity);
  @override
  _WeatherFutureDailyState createState() {
    return _WeatherFutureDailyState();
  }
}

class _WeatherFutureDailyState extends State<WeatherFutureDailyWidget> {
  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: (widget._daysWeatherEntity == null ||
              widget._daysWeatherEntity.daily == null)
          ? null
          : widget._daysWeatherEntity.daily.map((item) {
              return _WeatherDailyWidget(item);
            }).toList(),
    );
  }
}

//每一天的天气状况信息
class _WeatherDailyWidget extends StatelessWidget {
  //天气数据
  final DailyWeatherEntity _entity;

  _WeatherDailyWidget(this._entity);
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Flex(
        direction: Axis.vertical,
        //分成上下两部分，上面分白天和晚上显示天气
        children: <Widget>[
          //显示日期信息
          Expanded(
            flex: 1,
            child: Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: Text(DateUtils.formatMMdd(_entity.date)),
            ),
          ),

          //显示天气信息
          Expanded(
            flex: 2,
            child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                //白天的信息
                Expanded(
                  flex: 1,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    color: Colors.grey[50],
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: <Widget>[
                          //白天天气图片
                          Image(
                            image: AssetImage(
                                WeatherUtils.checkWeatherImagePath(
                                    _entity.code_day)),
                            width: 20.0,
                            height: 20.0,
                          ),
                          //白天天气文字
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              _entity.text_day,
                              style: TextStyle(
                                fontSize: 12.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //晚上的信息
                Expanded(
                  flex: 1,
                  child: Container(
                    constraints: BoxConstraints.expand(),
                    color: Colors.grey[200],
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0),
                      child: Column(
                        children: <Widget>[
                          //晚上天气图片
                          Image(
                            image: AssetImage(
                                WeatherUtils.checkWeatherImagePath(
                                    _entity.code_night)),
                            width: 20.0,
                            height: 20.0,
                          ),
                          //晚上天气文字
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              _entity.text_night,
                              style: TextStyle(
                                fontSize: 12.0
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),

          //显示温度
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                "${_entity.low}℃ ~ ${_entity.high}℃",
              ),
            ),
          ),
        ],
      ),
    );
  }
}
