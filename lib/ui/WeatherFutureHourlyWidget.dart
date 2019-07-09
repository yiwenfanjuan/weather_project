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
        : ListView.builder(
            //横向滚动
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return _ItemWeatherFutureHourlyWidget(
                  widget._hourlyWeatherEntity.hourly[index], index);
            },
            itemCount: widget._hourlyWeatherEntity.hourly.length,
          
          );
  }
}

//ListView的每一个Item
class _ItemWeatherFutureHourlyWidget extends StatelessWidget {
  final HourlyWeatherEntity _hourlyWeatherEntity;
  final int position;

  _ItemWeatherFutureHourlyWidget(this._hourlyWeatherEntity, this.position);

  @override
  Widget build(BuildContext context) {
    return _hourlyWeatherEntity == null
        ? null
        : Container(
            constraints: BoxConstraints.tightFor(width: 50.0),
            padding: EdgeInsets.only(
                left: getLeftPadding(), top: 10.0, bottom: 10.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //顶部是当前天气的图标
                Container(
                  constraints: BoxConstraints.tightFor(width: 30.0),
                  alignment: Alignment.topCenter,
                  child: AspectRatio(
                    //长宽比为1：1
                    aspectRatio: 1 / 1,
                    child: Image(
                      image: AssetImage(WeatherUtils.checkWeatherImagePath(
                          _hourlyWeatherEntity.code)),
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                ),
                //天气文字
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Text(
                    "${_hourlyWeatherEntity.temperature}°",
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
                //时间
                Padding(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    DateUtils.formatHHMM(_hourlyWeatherEntity.time),
                    style: TextStyle(fontSize: 12.0, color: Colors.white54),
                  ),
                ),
              ],
            ),
          );
  }

  //获取距离左边的padding
  num getLeftPadding() {
    return position == 0 ? 16.0 : 10.0;
  }
}
