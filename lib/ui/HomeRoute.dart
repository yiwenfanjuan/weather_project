import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:weather_project/data/constant.dart';
import 'package:weather_project/data/database/dbHelper.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
import 'package:weather_project/event/event_database_change.dart';
import 'package:weather_project/ui/WeatherInfoTab.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:amap_location/amap_location.dart';
import 'package:weather_project/ui/dialog/loading_dialog.dart';
import 'insert_city.dart';

class HomeRoute extends StatefulWidget {
  @override
  _HomeRouteState createState() {
    return _HomeRouteState();
  }
}

class _HomeRouteState extends State<HomeRoute> {
  //tabView的页面
  List<Widget> _weatherWidgetList;

  //本地保存的地址信息
  List<LocationEntity> _locationList;

  //PageView管理器
  final PageController _pageController = PageController();

  BuildContext _context;

  //监听数据库数据改变的时间
  //这里不一定非要用这种方式实现，也可以根据下个页面返回的数据去做相应的操作
  void updateDatabaseChange() {
    databaseChangeEvent.addCallback(Constant.DATABASE_INSERT_LOCATION, (arg) {
      //数据库中的数据成功插入之后会发送通知，在这里在最后一个页面之前插入数据
      _weatherWidgetList.insert(_weatherWidgetList.length - 1,
          WeatherInfoWidget((arg as LocationEntity).name));
      _locationList.add(arg as LocationEntity);
      if (_weatherWidgetList.length > 5) {
        _weatherWidgetList.removeLast();
      }
      updatePageState();
    });
  }

  //更新页面状态
  void updatePageState() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    print("HomeRoute initState");
    updateDatabaseChange();
    _weatherWidgetList = List();
    //查看本地数据库中保存的地址信息,没有数据的话请求定位权限
    checkLocalLocation(true);
  }

  @override
  Widget build(BuildContext context) {
    print("绘制页面：${_weatherWidgetList.length}");
    this._context = context;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          PageView.custom(
            controller: _pageController,
            childrenDelegate: SliverChildBuilderDelegate(
              (context, index) {
                return _weatherWidgetList[index];
              },
              childCount: _weatherWidgetList.length,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose(){
    AMapLocationClient.shutdown();
    super.dispose();
  }

  //查看是否拥有定位权限
  checkLocationPermission() async {
    bool result = await checkPermissionResult([PermissionGroup.phone,PermissionGroup.storage,PermissionGroup.location]);
    if (!result) {
      //用户没有同意授权
      print("用户没有同意授予定位权限");
      //查看是否可以再次弹框询问用户操作
      bool doNotRemind = await checkDoNotRemind([PermissionGroup.phone,PermissionGroup.storage,PermissionGroup.location]);
      if (doNotRemind) {
        print("shouldShowRequestPermissionRationale");
        //用户选择了不再询问,显示一个添加地址的页面
        _weatherWidgetList.add(InsertCityWidget());
      } else {
        //弹框提醒用户授予权限
        var result = await showPermissionRemindDialog();
        if (result == "cancel") {
          //用户拒绝授予权限，提供一个插入数据的页面
          _weatherWidgetList.add(InsertCityWidget());
          updatePageState();
        } else {
          //用户同意授权，开始申请权限
          Map<PermissionGroup, PermissionStatus> permissionResult =
              await requestPermission();
          //遍历查询是否所有权限都已经获取了
          Iterable<MapEntry<PermissionGroup, PermissionStatus>> iterable =
              permissionResult.entries;
          Iterator<MapEntry<PermissionGroup, PermissionStatus>> iterator =
              iterable.iterator;
          while (iterator.moveNext()) {
            if (iterator.current.value != PermissionStatus.granted) {
              //有一个权限没有获取到
              _weatherWidgetList.add(InsertCityWidget());
              updatePageState();
              return;
            }
          }
          //所有权限都已经获取到了
          startLocation();
        }
      }
    } else {
      //已经有当前权限了
      await startLocation();
    }
  }

  //进行权限申请
  Future<Map<PermissionGroup, PermissionStatus>> requestPermission() async {
    return await PermissionHandler().requestPermissions(
        [PermissionGroup.location, PermissionGroup.storage,PermissionGroup.phone]);
  }

  //调用高德地图进行位置信息获取
  Future<Null> startLocation() async {
    showLoading();
    await AMapLocationClient.startup(new AMapLocationOption(
        desiredAccuracy: CLLocationAccuracy.kCLLocationAccuracyHundredMeters));
    //直接获取定位
    AMapLocation location = await AMapLocationClient.getLocation(true);
    print("获取到的定位信息：${location.description}");
    //查看获取到的定位信息是否合法
    
    if(location != null && location.city != null && location.city.isNotEmpty){
     String city = location.city;
     if(location.city.contains("市",location.city.length - 1)){
        city = location.city.replaceFirst("市", "",location.city.length - 1);
      }
      //将当前城市加入到数据库中
      //TODO 这里有漏洞，因为没有在数据库中插入Path信息，会出问题，同一个城市可能会被多次加入
      Map<String,dynamic> map = HashMap();
      map["name"] = city;
      DBUtils().insertData(DBUtils.TABLE_LOCATION, map);
      _weatherWidgetList.add(WeatherInfoWidget(city));
      _weatherWidgetList.add(InsertCityWidget());
    }else{
      //获取位置信息失败，
      _weatherWidgetList.add(InsertCityWidget());
    }
    updatePageState();
    dismissDialog();
  }

  //查看权限结果
  Future<bool> checkPermissionResult(List<PermissionGroup> permissionList)async{
    if(permissionList == null || permissionList.isEmpty){
      return true;
    }else{
      for (var item in permissionList) {
         PermissionStatus status = await PermissionHandler().checkPermissionStatus(item);
        if(status != PermissionStatus.granted){
          return false;
        }
      }
      return true;
    }
  }

  //查看用户是否选择了不再提醒
  Future<bool> checkDoNotRemind(List<PermissionGroup> permissionList) async {
    if(permissionList == null || permissionList.isEmpty){
      return false;
    }

    for (var item in permissionList) {
      bool result = await await PermissionHandler()
              .shouldShowRequestPermissionRationale(item);
      if(result){
        return true;
      }
    }
    return false;
  }

  //获取本地数据库中保存的数据
  getLocalLocationList() async {
    List<Map<String, dynamic>> mapList =
        await DBUtils().queryData(DBUtils.TABLE_LOCATION);

    _locationList = mapList.map<LocationEntity>((element) {
      return LocationEntity.fromDatabase(element);
    }).toList();
  }

  //获取本地数据库中保存的地址列表信息
  checkLocalLocation(bool requestPermission) async {
    showLoading();
    print("地区列表：${_locationList == null ? null : _locationList.length}");
    await getLocalLocationList();
    //查看本地是否存在数据
    if (_locationList != null && _locationList.isNotEmpty) {
      //本地存在数据
      _locationList.forEach((element) {
        _weatherWidgetList.add(WeatherInfoWidget(element.name));
      });
      //查看本地数据库中的数据如果小于可以设置的最大值，就将加入城市的页面添加进去
      if (_weatherWidgetList.length < Constant.MAX_CITY_VALUE) {
        _weatherWidgetList.add(InsertCityWidget());
      }
      //刷新页面
      updatePageState();
    } else if (requestPermission) {
      //本地数据库没有数据，查看是否拥有定位权限
      await checkLocationPermission();
    }
    dismissDialog();
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

  //显示提醒用户授予权限的dialog
  Future<String> showPermissionRemindDialog() {
    return Future.delayed(Duration.zero, () {
      return showDialog(
          context: _context,
          builder: (context) {
            return AlertDialog(
              title: Text("权限提醒"),
              content: Text("应用需要定位权限来提供天气信息，如果不想授予权限，也可以在设置中添加城市信息"),
              actions: <Widget>[
                //点击授予权限
                FlatButton(
                  child: Text("授予权限"),
                  onPressed: () {
                    Navigator.of(context).pop("confirm");
                  },
                ),
                //点击取消授权
                FlatButton(
                  child: Text("取消授权"),
                  onPressed: () {
                    Navigator.of(context).pop("cancel");
                  },
                ),
              ],
            );
          });
    });
  }
}
