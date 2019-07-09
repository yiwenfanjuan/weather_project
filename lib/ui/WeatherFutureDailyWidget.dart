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
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
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
    return Container(
      constraints: BoxConstraints.expand(height: 50.0),
      alignment: Alignment.center,
      child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            //当前的日期
            Expanded(
              flex: 1,
              child: Text(
                DateUtils.formatWeek(_entity.date),
                style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),

              ),
            ),
            //天气图片
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Image(
                image: AssetImage(WeatherUtils.checkWeatherImagePath(_entity.code_day)),
                width: 20.0,
                height: 20.0,
                
              ),
            ),
            //温度信息
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text:"${_entity.high}°",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                      ),
                    ),
                    TextSpan(
                      text: "/${_entity.low}°",
                      style: TextStyle(
                        color: Colors.white60,
                        fontSize: 12.0,
                      ),
                    ),
                  ]
                ),
              ),
            ),
          ],
      ),
    );
  }
}
