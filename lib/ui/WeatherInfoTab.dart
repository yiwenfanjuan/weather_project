import 'dart:ui' as prefix0;

import 'package:flutter/material.dart';
import 'package:weather_project/data/air/AirInfo.dart';
import 'package:weather_project/data/air/AirResultInfo.dart';
import 'package:weather_project/data/life/LifeSuggestionInfo.dart';
import 'package:weather_project/data/weather/FutureDailyWeatherInfo.dart';
import 'package:weather_project/data/weather/FutureHourlyWeatherInfo.dart';
import 'package:weather_project/data/weather/NowWeatherEntity.dart';
import 'package:weather_project/http/WeatherApi.dart';
import 'package:weather_project/ui/LifeSuggestionWidget.dart';
import 'package:weather_project/ui/WeatherFutureDailyWidget.dart';
import 'package:weather_project/ui/WeatherFutureHourlyWidget.dart';
import 'package:weather_project/ui/dialog/loading_dialog.dart';
import 'package:weather_project/ui/search_city.dart';
import 'package:weather_project/utils/DateUtils.dart';

/**
 * 天气信息显示的TabView
 */
class WeatherInfoWidget extends StatefulWidget {
  //需要请求信息的城市名称
  final String _cityName;

  WeatherInfoWidget(@required this._cityName);

  @override
  _WeatherInfoWidgetState createState() {
    return _WeatherInfoWidgetState();
  }
}

class _WeatherInfoWidgetState extends State<WeatherInfoWidget> with AutomaticKeepAliveClientMixin{
  //当前城市的天气信息
  NowWeatherEntity _weatherEntity;
  //当前城市的空气信息
  AirResultEntity _airResultEntity;
  //未来24小时天气信息
  FutureHourlyWeatherEntity _futureHourlyWeatherEntity;
  //未来5天天气信息
  FutureDaysWeatherEntity _daysWeatherEntity;
  //生活指数信息
  LifeSuggestionEntity _lifeSuggestionEntity;

  BuildContext _context;
  @override
  void initState() {
    super.initState();
    doData();
  }

  //更新页面状态
  void _updatePageState(){
    if(mounted){
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    //使用可滚动控件显示当天的天气信息
    return RefreshIndicator(
      onRefresh: doData,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //显示天气信息
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 300.0),
              child: DecoratedBox(
                child: _weatherEntity == null
                    ? null
                    : _WeatherDetailsWidget(_weatherEntity,
                        airEntity: _airResultEntity.air.city),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                  //从右上角开始
                  begin: Alignment.topRight,
                  //到左下角结束
                  end: Alignment.bottomLeft,
                  colors: <Color>[
                    _weatherEntity == null
                        ? NowWeatherDetailsEntity.SUNNY_START_COLOR
                        : _weatherEntity.now.startColor,
                    _weatherEntity == null
                        ? NowWeatherDetailsEntity.SUNNY_END_COLOR
                        : _weatherEntity.now.endColor,
                  ],
                )),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "未来24小时天气状况",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14.0,
                ),
                textAlign: TextAlign.start,
              ),
            ),

            //分割线
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.black12,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),
            //显示从当前时间开始的未来24小时的天气预报
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 120.0),
              
              child: _futureHourlyWeatherEntity == null
                  ? null
                  : DecoratedBox(
                    decoration: BoxDecoration(color: Colors.grey[100]),
                    child: WeatherFutureHourlyWidget(_futureHourlyWeatherEntity),),
            ),

            //分割线
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.grey[200],
                  shape: BoxShape.rectangle,
                ),
              ),
            ),

            //5天天气状况预测
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "5天天气状况预测",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),

            //分割线
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.black12,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),

            //5天天气数据列表
            Container(
              constraints: BoxConstraints.expand(height: 150.0),
              color: Colors.grey[10],
              child: _daysWeatherEntity == null
                  ? null
                  : WeatherFutureDailyWidget(_daysWeatherEntity),
            ),

            //分割线
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.black12,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),

              //5天天气状况预测
            Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                "生活指数",
                style: TextStyle(color: Colors.black, fontSize: 14),
              ),
            ),

            //分割线
            ConstrainedBox(
              constraints: BoxConstraints.expand(height: 1.0),
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(3.0),
                  color: Colors.black12,
                  shape: BoxShape.rectangle,
                ),
              ),
            ),

            //生活指数信息
            Container(
              constraints: BoxConstraints.tightFor(),
              child: _lifeSuggestionEntity == null
                  ? null
                  : LifeSuggestionListWidget(_lifeSuggestionEntity),
            ),
          ],
        ),
      ),
    );
  }

  //请求数据
  Future<Null> doData() async {
    showLoading();
    //请求天气信息
    NowWeatherListEntity weatherData =
        await WeatherApi<NowWeatherEntity>().doNowWeather(widget._cityName);
    //请求空气质量信息
    AirResultListEntity airData =
        await WeatherApi<AirResultListEntity>().doAirInfo(widget._cityName);
    //请求24小时天气信息
    FutureHourlyWeatherResultsEntity hourlyData =
        await WeatherApi<FutureHourlyWeatherResultsEntity>()
            .doFutureHourly(widget._cityName);
    //请求未来5天天气信息
    FutureDaysWeatherResultsEntity daysWeatherEntity =
        await WeatherApi<FutureDaysWeatherResultsEntity>()
            .doFutureDailyWeather(widget._cityName);
    //请求生活指数信息
    LifeSuggestionResultsEntity suggestionResultsEntity =
        await WeatherApi<LifeSuggestionResultsEntity>()
            .doSuggestionInfo(widget._cityName);
    if (weatherData != null && weatherData.results != null) {
      _weatherEntity = weatherData.results[0];
    }

    if (airData != null && airData.results != null) {
      _airResultEntity = airData.results[0];
    }

    if (hourlyData != null && hourlyData.results != null) {
      _futureHourlyWeatherEntity = hourlyData.results[0];
    }

    if (daysWeatherEntity != null && daysWeatherEntity.results != null) {
      _daysWeatherEntity = daysWeatherEntity.results[0];
    }

    if (suggestionResultsEntity != null &&
        suggestionResultsEntity.results != null &&
        suggestionResultsEntity.results.isNotEmpty) {
      _lifeSuggestionEntity = suggestionResultsEntity.results[0].suggestion;
    } else {
      print("生活指数为空");
    }
    _updatePageState();
    dismissDialog();
    return null;
  }

   //显示等待的dialog
  void showLoading() {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: _context,
          barrierDismissible: false,
          builder: (context) {
            return LoadingDialogWidget();
          });
    });
  }

  //隐藏dialog
  void dismissDialog() {
    Future.delayed(Duration.zero, () {
      Navigator.pop(context);
    });
  }


  @override
  bool get wantKeepAlive => true;
}

//显示天气详情的widget
class _WeatherDetailsWidget extends StatelessWidget {
  //天气详情数据
  final NowWeatherEntity _weatherEntity;
  //空气质量数据
  CityAirEntity _airEntity;

  _WeatherDetailsWidget(this._weatherEntity, {CityAirEntity airEntity}) {
    this._airEntity = airEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Stack(
        fit: StackFit.expand,
        alignment: Alignment.centerLeft,
        children: <Widget>[
          //顶部显示当前的城市信息
          Positioned(
            left: 15.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.location_city,
                  color: Colors.white,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text(
                    "${_weatherEntity.location.name}(${_weatherEntity.location.country})",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0),
                  ),
                )
              ],
            ),
          ),
          //底部显示当前的天气信息
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //风力信息
                Chip(
                  avatar: CircleAvatar(
                    backgroundColor: Colors.white70,
                    child: Padding(
                      padding: EdgeInsets.all(2.0),
                      child: Image.asset(
                        "icons/icon_windy.png",
                        color: Colors.grey,
                        width: 40.0,
                        height: 40.0,
                      ),
                    ),
                  ),
                  label: RichText(
                    text: TextSpan(
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      children: [
                        TextSpan(
                          text: "风力：",
                        ),
                        TextSpan(
                            text: "${_weatherEntity.now.wind_direction} 风"),
                        TextSpan(text: " · ${_weatherEntity.now.wind_scale} 级"),
                      ],
                    ),
                  ),
                ),
                //温度和湿度信息
                Padding(
                  padding: EdgeInsets.only(top: 3.0, left: 5.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      //温度信息
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24.0,
                            ),
                            text: "${_weatherEntity.now.temperature}℃",
                          ),
                          TextSpan(
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0),
                            text: "/${_weatherEntity.now.feels_like}℃",
                          ),
                        ]),
                      ),

                      //湿度信息
                      Padding(
                        padding: EdgeInsets.only(left: 20.0),
                        child: Row(
                          children: <Widget>[
                            //湿度图片
                            Image(
                              image: AssetImage("icons/icon_humidity.png"),
                            ),
                            //湿度信息
                            Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Text(
                                "${_weatherEntity.now.humidity}%",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          //右上角显示天气图片
          Positioned(
            right: 15.0,
            top: 15.0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image(
                    image: AssetImage(_weatherEntity.now.imagePath),
                    width: 100.0,
                    height: 100.0,
                    fit: BoxFit.contain,
                  ),
                  //显示当前的天气状况
                  Padding(
                    padding: EdgeInsets.only(top: 5.0),
                    child: Text(
                      _weatherEntity.now.text,
                      style: TextStyle(fontSize: 20.0, color: Colors.white),
                    ),
                  ),
                  //显示最后更新时间
                  Padding(
                    padding: EdgeInsets.only(top: 3.0),
                    child: Text(
                      "最后更新于:${DateUtils.updateTime(_weatherEntity.last_update)}",
                      style: TextStyle(fontSize: 12.0, color: Colors.white70),
                    ),
                  ),
                ]),
          ),
          //右下角显示空气质量信息
          Positioned(
            right: 15.0,
            bottom: 15.0,
            child: _airEntity == null
                ? null
                : GestureDetector(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "空气质量 : ${_airEntity.quality}",
                              style: TextStyle(
                                  fontSize: 16.0, color: Colors.white),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 10.0),
                              child: Text(
                                "PM2.5 : ${_airEntity.pm25}",
                                style: TextStyle(
                                  color: Colors.white54,
                                  fontSize: 16.0,
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15.0),
                          child: ConstrainedBox(
                            constraints: BoxConstraints.loose(Size(25.0, 25.0)),
                            child: CircleAvatar(
                              backgroundColor: Colors.white70,
                              child: Icon(
                                Icons.arrow_right,
                                color: Colors.grey,
                                size: 15.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      print("点击空气质量部分");
                    },
                  ),
          )
        ],
      ),
    );
  }
}
