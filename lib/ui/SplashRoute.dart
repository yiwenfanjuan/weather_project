import 'package:flutter/material.dart';
import 'dart:math';
import 'package:weather_project/ui/HomeRoute.dart';

/**
 * APP启动页
 */
class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //返回APP启动页的信息，是一个动画图标和一行文本，显示数据来源
    return Scaffold(
      body: Flex(
        direction: Axis.vertical,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Center(
              child: _SunWidget(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.only(bottom: 20.0),
              alignment: Alignment.bottomCenter,
              child: Text("数据来自于:心知天气"),
            ),
          ),
        ],
      ),
    );
  }
}

class _SunWidget extends StatefulWidget {
  @override
  _SunState createState() {
    return _SunState();
  }
}

class _SunState extends State<_SunWidget> with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController _controller;
  //动画实例
  Animation _animation;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.bounceIn);
    _animation = Tween(begin: 0.0, end: 100.0).animate(_controller);
    _animation.addListener(() {
      setState(() {});
    });
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) {
            return HomeRoute();
          }),
          (route) => route == null,
        );
      }
    });
    _playAnimation();
  }

  _playAnimation() async {
    await _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter:
          _SunView(_animation.value != null ? _animation.value.toInt() : 0),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

//自定义太阳图标
class _SunView extends CustomPainter {
  //构造方法
  _SunView(this._sunArroundStart);

  //画笔
  Paint _mPaint;
  //圆的半径
  var _sunCircleRadius = 50.0;
  //宽和高
  var _width;
  var _height;

  //绘制光芒的起点
  int _sunArroundStart = 0;

  //光芒的间隔角度，默认60度
  var _sunArroundinterval = 40;

  //光芒的长度
  var _sunArroundLineLength = 40;

  @override
  void paint(Canvas canvas, Size size) {
    _initPaint();

    //获取可用的宽度和高度
    if (size != null && size.width > 0 && size.height > 0) {
      var realSize = min(size.width, size.height);
      _sunCircleRadius = min(realSize / 4, _sunCircleRadius);
    }

    _width = _sunCircleRadius * 4;
    _height = _width;

    //绘制一个圆
    canvas.drawCircle(Offset(0, 0), _sunCircleRadius, _mPaint);
    //在圆的周围绘制
    drawSunAround(canvas);
  }

  //绘制光芒
  void drawSunAround(Canvas canvas) {
    //根据角度计算点
    for (int i = 0; i < 360 ~/ _sunArroundinterval; i++) {
      var currentPointX =
          (_sunCircleRadius + 10) * cos(_sunArroundStart * pi / 180);
      var currentPointY =
          (_sunCircleRadius + 10) * sin(_sunArroundStart * pi / 180);

      //光芒到达的位置
      var finalPointX = (_sunCircleRadius + _sunArroundLineLength) *
          cos(_sunArroundStart * pi / 180);
      var finalPointY = (_sunCircleRadius + _sunArroundLineLength) *
          sin(_sunArroundStart * pi / 180);
      //绘制横线
      canvas.drawLine(Offset(currentPointX, currentPointY),
          Offset(finalPointX, finalPointY), _mPaint);

      _sunArroundStart += _sunArroundinterval;
    }
  }

  //初始化paint
  void _initPaint() {
    if (_mPaint == null) {
      _mPaint = Paint();
      //设置属性
      _mPaint.isAntiAlias = true;
      _mPaint.color = Colors.orangeAccent[700];
      _mPaint.style = PaintingStyle.fill;
      _mPaint.strokeCap = StrokeCap.round;
      _mPaint.strokeJoin = StrokeJoin.round;
      _mPaint.strokeWidth = 7;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    if (oldDelegate == this) {
      return false;
    }
    return true;
  }
}
