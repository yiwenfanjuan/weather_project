import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:weather_project/data/constant.dart';
import 'package:weather_project/data/database/dbHelper.dart';
import 'package:weather_project/data/location/LocationEntity.dart';
import 'package:weather_project/event/event_database_change.dart';
import 'package:weather_project/ui/search_city.dart';
import 'package:weather_project/utils/WeatherUtils.dart';
import 'package:weather_project/utils/color_utils.dart';
import 'widget/widget_search.dart';
import 'package:build_daemon/constants.dart';

/**
 * 城市管理页面
 * 可以在此页面对已经添加的城市进行管理
 */
class CityManagerRoute extends StatefulWidget {
  @override
  _CityManagerState createState() {
    return _CityManagerState();
  }
}

class _CityManagerState extends State<CityManagerRoute> {
  BuildContext _context;
  List<LocationEntity> _locationList;

  //监听数据库中数据的变化，即时刷新页面
  void updateDatabaseChange() {
    //添加数据库事件监听
    databaseChangeEvent.addCallback(Constant.DATABASE_INSERT_LOCATION, (arg) {
      //数据库中的数据成功插入之后会发送通知，在这里在最后一个页面之前插入数据
      _locationList.add(arg as LocationEntity);
      updatePage();
    });

    databaseChangeEvent.addCallback(Constant.DATABASE_DELETE_LOCATION, (arg) {
      LocationEntity entity = (arg as LocationEntity);
      int removePostion = -1;
      for (int i = 0; i < _locationList.length; i++) {
        if (_locationList[i].name == entity.name &&
            _locationList[i].path == entity.path) {
          removePostion = i;
          break;
        }
      }
      _locationList.removeAt(removePostion);
      updatePage();
    });
  }

  @override
  void initState() {
    super.initState();
    _locationList = List();
    //读取数据库中的城市列表
    initCityList();
    //监控数据库中数据变化
    updateDatabaseChange();
  }

  //更新页面
  void updatePage() {
    if (mounted) {
      setState(() {});
    }
  }

  void initCityList() async {
    List<Map<String, dynamic>> list =
        await DBUtils().queryData(DBUtils.TABLE_LOCATION);
    if (list == null || list.isEmpty) {
      showError("尚未添加任何城市", _context);
      return;
    }
    for (var item in list) {
      LocationEntity entity = LocationEntity.fromDatabase(item);
      _locationList.add(entity);
    }
    updatePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Builder(
        builder: (context) {
          this._context = context;
          return Container(
            constraints: BoxConstraints.expand(),
            //不要添加到状态栏
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).padding.top + 10),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: ColorUtils.getColorWithTime(),
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Flex(
              direction: Axis.vertical,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                //顶部是一个添加城市信息的按钮
                AddCityButtonWidget(),
                //下面是一个ListView的列表
                _locationList == null
                    ? null
                    : Expanded(
                        flex: 1,
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          reverse: false,
                          itemBuilder: (context, position) =>
                              _InsertedCityItemWidget(
                                  position, _locationList[position]),
                          itemCount: _locationList.length,
                        ),
                      ),
              ],
            ),
          );
        },
      ),
    );
  }
}

//添加城市按钮
class AddCityButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints: BoxConstraints.tightFor(),
        padding: EdgeInsets.only(left: 16.0, right: 16.0),
        child: Flex(
          direction: Axis.horizontal,
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Text(
                "添加城市",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            //搜索按钮
            Icon(
              Icons.search,
              color: Colors.white,
              size: 30.0,
            ),
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SearchCityWidget(),
            ));
      },
    );
  }
}

//ListView的Item，根据手指的移动可以进行移除
class _InsertedCityItemWidget extends StatelessWidget {
  final int position;
  final LocationEntity _locationEntity;

  _InsertedCityItemWidget(this.position, this._locationEntity)
      : assert(_locationEntity != null),
        assert(position >= 0);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: Container(
        padding:
            EdgeInsets.only(top: 10.0, left: 16.0, bottom: 10.0, right: 16.0),
        constraints: BoxConstraints.expand(height: 100.0),
        color: Colors.blueAccent,
        child: Stack(
          alignment: AlignmentDirectional.centerEnd,
          fit: StackFit.expand,
          //左边显示城市和城市详细信息
          children: <Widget>[
            Positioned(
              child: Flex(
                direction: Axis.vertical,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Text(
                      _locationEntity.name,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      "${_locationEntity.path}",
                      style: TextStyle(color: Colors.white54, fontSize: 14.0),
                    ),
                  )
                ],
              ),
            ),

            //右边显示一个删除按钮
            Positioned(
              right: 0,
              child: GestureDetector(
                child: RoundButtonWidget(
                  "删除",
                  TextStyle(color: Colors.white),
                  10.0,
                  borderSize: 2.0,
                  borderColor: Colors.grey,
                  paddingEdge:
                      EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                ),
                onTap: () {
                  //点击删除一个城市
                  deleteCity(_locationEntity, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  //删除城市
  void deleteCity(LocationEntity entity, BuildContext context) async {
    showLoading(context);
    if (entity == null) {
      showError("要删除的地址不存在，请检查", context);
      dismissDialog(context);
      return;
    }

    List<dynamic> deleteList = List<dynamic>();
    if (entity.columnId != null && entity.columnId > -1) {
      deleteList.add(entity.columnId);
      await DBUtils().deleteCity(
        DBUtils.TABLE_LOCATION,
        where: "columnId = ?",
        whereArgs: deleteList,
      );
    } else {
      deleteList.add(entity.name);
      await DBUtils().deleteCity(DBUtils.TABLE_LOCATION,
          where: "name = ?", whereArgs: deleteList);
    }

    //从首页的列表中删除当前城市
    databaseChangeEvent.commit(Constant.DATABASE_DELETE_LOCATION, entity);
    //隐藏loading
    dismissDialog(context);
    return;
  }


}
