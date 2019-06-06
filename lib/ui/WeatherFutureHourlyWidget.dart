import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/data/weather/FutureHourlyWeatherInfo.dart';
import 'package:weather_project/utils/DateUtils.dart';
import 'package:weather_project/utils/WeatherUtils.dart';

/**
 * 未来24小时天气数据
 * 一个横向滚动的ListView
 */
class WeatherFutureHourlyWidget extends StatefulWidget {
  final FutureHourlyWeatherEntity _hourlyWeatherEntity;

  WeatherFutureHourlyWidget(this._hourlyWeatherEntity);

  @override
  _WeatherFutureHourlyState createState() {
    return _WeatherFutureHourlyState();
  }
}

class _WeatherFutureHourlyState extends State<WeatherFutureHourlyWidget> {
  @override
  Widget build(BuildContext context) {
    return widget._hourlyWeatherEntity == null ||
            widget._hourlyWeatherEntity.hourly == null
        ? null
        : ListView.separated(
              //横向滚动
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return _ItemWeatherFutureHourlyWidget(
                    widget._hourlyWeatherEntity.hourly[index]);
              },
              itemCount: widget._hourlyWeatherEntity.hourly.length,
              separatorBuilder: (context, index) {
                //分割线
                return ConstrainedBox(
                  constraints: BoxConstraints.expand(width: 2.0),
                  child: Padding(
                    padding: EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: DecoratedBox(
                      decoration: BoxDecoration(color: Colors.grey[200]),
                    ),
                  ),
                );
              },
          );
  }
}

//ListView的每一个Item
class _ItemWeatherFutureHourlyWidget extends StatelessWidget {
  final HourlyWeatherEntity _hourlyWeatherEntity;

  _ItemWeatherFutureHourlyWidget(this._hourlyWeatherEntity);

  @override
  Widget build(BuildContext context) {
    return _hourlyWeatherEntity == null
        ? null
        : ConstrainedBox(
            constraints: BoxConstraints.expand(width: 200.0),
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.grey[100],
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    top: 10.0, bottom: 10.0, left: 15.0, right: 15.0),
                child: Flex(
                  direction: Axis.vertical,
                  //默认上面中间的位置
                  children: <Widget>[
                    //顶部是天气图片
                    Expanded(
                      flex: 2,
                      child: Column(children: <Widget>[
                        Image(
                          image: AssetImage(WeatherUtils.checkWeatherImagePath(
                              _hourlyWeatherEntity.code)),
                          width: 40.0,
                          height: 40.0,
                          fit: BoxFit.scaleDown,
                        ),
                        //天气状况文字和温度
                        RichText(
                         text: TextSpan(
                           children: <TextSpan>[
                             //天气文字
                             TextSpan(
                               text: _hourlyWeatherEntity.text,
                               style: TextStyle(
                                 color: Colors.black
                               ),
                             ),
                             //温度数据
                             TextSpan(
                               text: " (${_hourlyWeatherEntity.temperature}℃)",
                               style: TextStyle(
                                 color: Colors.deepOrange
                               ),
                             ),
                           ]
                         ),
                        )
                      ]),
                    ),
                    //底部显示温度，相对湿度和风向
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: <Widget>[
                          //显示更新时间
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                    color: Colors.orangeAccent, fontSize: 10.0),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "${DateUtils.updateTime(_hourlyWeatherEntity.time)}"),
                                ],
                              ),
                            ),
                          ),
                          //风向和风速
                          Positioned(
                            left: 0,
                            bottom: 0,
                            child: RichText(
                              text: TextSpan(
                                style: TextStyle(
                                  fontSize: 10.0,
                                  color: Colors.blueAccent[400],
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                      text:
                                          "${_hourlyWeatherEntity.wind_direction}风 · "),
                                  TextSpan(
                                    text:
                                        "${_hourlyWeatherEntity.wind_speed}km/h",
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
