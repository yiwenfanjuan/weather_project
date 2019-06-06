import 'package:flutter/material.dart';
import 'package:weather_project/ui/search_city.dart';

/**
 * 插入城市数据的页面
 */

class InsertCityWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(),
      child: Padding(
        padding:
            EdgeInsets.only(top: 40.0, bottom: 40.0, left: 10.0, right: 10.0),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.white54,
                offset: Offset(4.0, 4.0),
                blurRadius: 4.0,
              ),
            ],
            shape: BoxShape.rectangle,
          ),
          child: GestureDetector(
            child: Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                //添加城市图标
                Icon(
                  Icons.add,
                  size: 50.0,
                ),
                Text(
                  "点击搜索需要添加的城市",
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.black,
                  ),
                ),
              ],
            )),
            onTap: () {
              //点击添加城市：
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return SearchCityWidget();
              }));
            },
          ),
        ),
      ),
    );
  }
}
