import 'dart:ui';
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
import 'package:weather_project/utils/color_utils.dart';

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

class _WeatherInfoWidgetState extends State<WeatherInfoWidget>
    with AutomaticKeepAliveClientMixin {
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
  void _updatePageState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    this._context = context;
    return Container(
      constraints: BoxConstraints.expand(),
      decoration: BoxDecoration(
          gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: ColorUtils.getColorWithTime(),
      )),
      child: RefreshIndicator(
        onRefresh: doData,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                //显示天气信息
                Container(
                  child: (_weatherEntity == null || _airResultEntity == null)
                      ? null
                      : _WeatherDetailsWidget(_weatherEntity,
                          airEntity: _airResultEntity.air.city),
                  constraints: BoxConstraints.expand(
                    height: (_weatherEntity == null ? 0 : 300.0),
                  ),
                ),

                //显示从当前时间开始的未来24小时的天气预报
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Container(
                    constraints: BoxConstraints.expand(height: 100.0),
                    child: _futureHourlyWeatherEntity == null
                        ? null
                        : Container(
                            child: WeatherFutureHourlyWidget(
                                _futureHourlyWeatherEntity),
                          ),
                  ),
                ),

                //5天天气数据列表
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    constraints: BoxConstraints.tightFor(),
                    child: _daysWeatherEntity == null
                        ? null
                        : WeatherFutureDailyWidget(_daysWeatherEntity),
                  ),
                ),

                //分割线
                Padding(
                  padding: EdgeInsets.only(top: 30.0),
                  child: Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        //line
                        Container(
                          constraints: BoxConstraints.tightFor(
                              width: 100.0, height: 1.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[Colors.white12, Colors.white]),
                          ),
                        ),

                        //文字
                        Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Text(
                            "生活指数",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                            ),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints.tightFor(
                              width: 100.0, height: 1.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(2.0),
                            gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: <Color>[Colors.white, Colors.white12]),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //生活指数信息
                Container(
                  padding: EdgeInsets.only(top: 10.0),
                  constraints: BoxConstraints.tightFor(),
                  child: _lifeSuggestionEntity == null
                      ? null
                      : LifeSuggestionListWidget(_lifeSuggestionEntity),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //请求数据
  Future<Null> doData() async {
    showLoading(context);
    //请求天气信息
    NowWeatherListEntity weatherData =
        await WeatherApi<NowWeatherEntity>().doNowWeather(widget._cityName);
    //请求空气质量信息
    AirResultListEntity airData =
        await WeatherApi<AirResultListEntity>().doAirInfo(widget._cityName);
    print("请求到的空气质量信息：${airData.toString()}");
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
    if (weatherData.success) {
      _weatherEntity = weatherData.results[0];
    }

    if (airData.success) {
      _airResultEntity = airData.results[0];
    }

    if (hourlyData.success) {
      _futureHourlyWeatherEntity = hourlyData.results[0];
    }

    if (daysWeatherEntity.success) {
      _daysWeatherEntity = daysWeatherEntity.results[0];
    }

    if (suggestionResultsEntity.success) {
      _lifeSuggestionEntity = suggestionResultsEntity.results[0].suggestion;
    }
    _updatePageState();
    dismissDialog(context);
  }

  //显示等待的dialog
  /*
  void showLoading(BuildContext context) {
    Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return LoadingDialogWidget();
          });
    });
  }

  //隐藏dialog
  void dismissDialog(BuildContext context) {
    Future.delayed(Duration.zero, () {
      Navigator.pop(context);
    });
  }
  */

  @override
  bool get wantKeepAlive => true;
}

//显示天气详情的widget
class _WeatherDetailsWidget extends StatelessWidget {
  //天气详情数据
  final NowWeatherEntity _weatherEntity;
  //空气质量数据
  CityAirEntity _airEntity;

  //空气质量数据的TextStyle
  final TextStyle _airTextStyle = TextStyle(
    fontSize: 14.0,
    color: Colors.white,
  );

  _WeatherDetailsWidget(this._weatherEntity, {CityAirEntity airEntity}) {
    this._airEntity = airEntity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        constraints: BoxConstraints.expand(),
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Flex(
            direction: Axis.horizontal,
            children: <Widget>[
              //左边显示体感温度，湿度，城市，风力信息
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: AlignmentDirectional.centerStart,
                  fit: StackFit.expand,
                  children: <Widget>[
                    Positioned(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //体感温度
                          Text(
                            "${_weatherEntity.now.feels_like}°",
                            style: TextStyle(
                              fontSize: 40.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w900,
                              shadows: [
                                Shadow(color: Colors.grey, blurRadius: 2.0),
                              ],
                            ),
                            textAlign: TextAlign.center,
                          ),
                          //湿度
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  constraints: BoxConstraints.tightFor(
                                      width: 20.0, height: 20.0),
                                  child: CircleAvatar(
                                    child: Image(
                                      image:
                                          AssetImage("icons/icon_humidity.png"),
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                                //湿度
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    "${_weatherEntity.now.humidity}%",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Row(
                              children: [
                                Container(
                                  constraints: BoxConstraints.tightFor(
                                      width: 18.0, height: 18.0),
                                  child: Image(
                                    image: AssetImage("icons/icon_windy.png"),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5.0),
                                  child: Text(
                                    "${_weatherEntity.now.wind_direction}风·${_weatherEntity.now.wind_scale}级",
                                    style: TextStyle(
                                        fontSize: 16.0, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //底部显示城市信息
                    Positioned(
                      bottom: 5.0,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(5.0)),
                          color: ColorUtils.getCityBackgroundWithTime(),
                        ),
                        constraints: BoxConstraints.tightFor(),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 8.0),
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_city,
                                size: 20.0,
                                color: Colors.white,
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 5.0),
                                child: Text(
                                  "${_weatherEntity.location.name}(${_weatherEntity.location.country})",
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              //右边显示天气图片和空气质量信息
              Expanded(
                flex: 1,
                child: Flex(
                  direction: Axis.vertical,
                  children: <Widget>[
                    //上部分显示天气图片
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top + 10),
                        child: Image(
                          image: AssetImage(_weatherEntity.now.imagePath),
                          fit: BoxFit.fitWidth,
                          width: 120.0,
                          height: 120.0,
                        ),
                      ),
                    ),
                    //下部分显示空气质量信息
                    Container(
                      padding: EdgeInsets.only(right: 16.0, top: 20.0),
                      child: _airEntity == null
                          ? null
                          :
                          //如果数据不为空就设置信息,根布局是一个事件监控的widget
                          GestureDetector(
                              child: Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment: MainAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                //左边显示空气质量指数,右边显示一个查看更多按钮
                                children: <Widget>[
                                  //空气质量指数
                                  Expanded(
                                    flex: 1,
                                    child: Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          //天气详情
                                          Text(
                                            _weatherEntity.now.text,
                                            style: _airTextStyle,
                                          ),
                                          //空气质量指数
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              "空气质量: ${_airEntity.quality}",
                                              style: _airTextStyle,
                                            ),
                                          ),
                                          //pm2.5信息
                                          Padding(
                                            padding: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              "PM2.5: ${_airEntity.pm25}",
                                              style: _airTextStyle,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  //查看更多按钮

                                  Container(
                                    constraints: BoxConstraints.tightFor(),
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(left: 10.0),
                                    child: Icon(
                                      Icons.chevron_right,
                                      color: Colors.white,
                                      size: 20.0,
                                    ),
                                  ),
                                ],
                              ),
                              onTap: () {
                                //点击跳转到空气详情页面
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
