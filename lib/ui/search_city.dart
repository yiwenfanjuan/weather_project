import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/data/constant.dart';
import 'package:weather_project/data/database/dbHelper.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
import 'package:weather_project/event/event_database_change.dart';
import 'package:weather_project/http/WeatherApi.dart';
import 'package:weather_project/ui/dialog/loading_dialog.dart';
import 'package:weather_project/utils/color_utils.dart';

//显示提醒用户的操作
void showError(String errorInfo, BuildContext context) {
  SnackBar snackBar = SnackBar(
    content: Text(
      errorInfo,
      style: TextStyle(
        fontSize: 12.0,
        color: Colors.white,
      ),
    ),
    duration: Duration(milliseconds: 1000),
    backgroundColor: Colors.grey[700],
  );

  Scaffold.of(context).showSnackBar(snackBar);
}

//显示等待的dialog
void showLoading(BuildContext context) async {
  if(context == null){
    print("context为空，无法显示dialog");
    return;
  }
  await Future.delayed(Duration.zero, () {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return LoadingDialogWidget();
        });
  });
}

//隐藏dialog
void dismissDialog(BuildContext context) async {
  if(context == null){
    print("context为空，无法显示dialog");
    return;
  }
  await Future.delayed(Duration.zero, () {
    Navigator.pop(context);
  });
}

/**
 * 搜索城市页面
 */
class SearchCityWidget extends StatefulWidget {
  @override
  SearchCityState createState() {
    return SearchCityState();
  }
}

class SearchCityState extends State<SearchCityWidget> {
  BuildContext _context;
  //输入框控制器
  TextEditingController _controller;
  //数据列表
  LocationListEntity _locationListEntity;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      body: Builder(
        builder: (context) => Container(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top + 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: ColorUtils.getColorWithTime(),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  //顶部是输入框和搜索按钮
                  Flex(
                    direction: Axis.horizontal,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      //返回按钮
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(left: 10.0, right: 10.0),
                          child: Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 20.0,
                          ),
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      //搜索框
                      Expanded(
                        flex: 1,
                        child: Container(
                          constraints: BoxConstraints.expand(height: 30.0),
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 10.0, right: 10.0),
                            child: TextField(
                              controller: _controller,
                              textAlignVertical: TextAlignVertical.center,
                              maxLines: 1,
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                showLoading(context);
                                requestData(_controller.text, context);
                              },
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                filled: true,
                                hasFloatingPlaceholder: false,
                                isDense: true,
                                hintText: "请输入要搜索的城市名或拼音",
                                hintStyle: TextStyle(
                                  fontSize: 12.0,
                                  color: Colors.grey,
                                ),
                                fillColor: Colors.white,
                              ),
                              style: TextStyle(
                                fontSize: 12.0,
                                color: Colors.black87,
                              ),
                              cursorColor: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      //搜索按钮
                      GestureDetector(
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                          child: Text(
                            "搜索",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        onTap: () {
                          showLoading(context);
                          requestData(_controller.text, context);
                        },
                      )
                    ],
                  ),
                  //下面是搜索结果信息，如果有结果就是结果列表，没有结果就提醒用户重新搜索
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: _locationListEntity == null
                          ? null
                          : (_locationListEntity.results == null ||
                                  _locationListEntity.results.isEmpty)
                              ?
                              //请求到的数据为空
                              GestureDetector(
                                  child: Center(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.hourglass_empty,
                                          size: 40.0,
                                          color: Colors.black38,
                                        ),
                                        Text("地址不存在，点击重新搜索"),
                                      ],
                                    ),
                                  ),
                                  onTap: () {
                                    //清空输入框中的数据
                                    _controller.clear();
                                  },
                                )
                              :
                              //请求到的数据不为空
                              ListView.separated(
                                  itemCount: _locationListEntity.results.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return _CityItemWidget(
                                        _locationListEntity.results[index]);
                                  },
                                  separatorBuilder: (context, index) {
                                    return ConstrainedBox(
                                      constraints:
                                          BoxConstraints.expand(height: 2.0),
                                      child: DecoratedBox(
                                        decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                    ),
                  ),
                ],
              ),
            ),
      ),
    );
  }

  //请求数据
  void requestData(String location, BuildContext context) async {
    if (location.isEmpty) {
      showError("请输入城市名", context);
      dismissDialog(_context);
      return;
    }
    _locationListEntity =
        await WeatherApi<LocationListEntity>().doSearchCity(location);
    setState(() {});
    dismissDialog(_context);
  }
}

//显示搜搜到的城市信息
class _CityItemWidget extends StatelessWidget {
  //城市信息
  final LocationEntity _locationEntity;
  _CityItemWidget(this._locationEntity);
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 80.0),
      child: _locationEntity == null
          ? null
          : Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //左边显示位置信息
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 15.0),
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _locationEntity.name,
                              style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            "${_locationEntity.path} · ${_locationEntity.country}",
                            style: TextStyle(
                              fontSize: 12.0,
                              color: Colors.white60,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                //右边显示将当前的数据加入到数据库中
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.0, right: 15.0),
                    child: Container(
                      constraints: BoxConstraints.tightFor(),
                      child: GestureDetector(
                        onTap: () {
                          //将当前数据加入到数据库中
                          insertData(context);
                        },
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: 3.0, bottom: 3.0, left: 10.0, right: 10.0),
                            child: Text("添加"),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  //将数据加入到数据库中
  insertData(BuildContext context) async {
    showLoading(context);
    //查看数据库中的数据是否超过最大值
    var result = await DBUtils().queryData(DBUtils.TABLE_LOCATION);
    if (result.length >= Constant.MAX_CITY_VALUE) {
      showError("最多可以只能添加5个城市", context);
      dismissDialog(context);
      return;
    } else {
      //遍历查询是否是重复数据
      for (var item in result) {
        if (item["name"] == _locationEntity.name &&
            item["path"] == _locationEntity.path) {
          print("查询到数据库中已经有当前数据了");
          showError("当前城市已经存在数据库中", context);
          dismissDialog(context);
          return;
        }
      }
      //将数据加入到数据库中
      Map<String, dynamic> map = HashMap();
      map["name"] = _locationEntity.name;
      map["path"] = _locationEntity.path;
      var data = await DBUtils().insertData(DBUtils.TABLE_LOCATION, map);
      if (data != null && data.isNotEmpty) {
        showError("插入数据库成功 ", context);
        //数据插入成功，发送事件通知
        databaseChangeEvent.commit(
            Constant.DATABASE_INSERT_LOCATION, _locationEntity);
        Navigator.of(context).pop();
      } else {
        showError("插入数据库失败,请重试", context);
      }
    }
    dismissDialog(context);
  }
}
