import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/**
 * 自定义等待的loading效果
 */

class LoadingView extends CustomPainter {
  //动画数值
  final Animation<double> animation;

  //画笔
  Paint _mPaint;

  //默认的宽度和高度
  double _defaultWidth = 100.0;
  double _defaultHeight = 100.0;

  //画笔默认颜色，灰色
  Color _defaultColor = Colors.grey;

  //绘制圆的半径
  double _defaultRadius = 35.0;

  //时针旋转的角度，动画会改变这个值
  //使用时针的旋转角度来计算分针的旋转角度，这样动画只需要在0~360之间一直执行即可
  double _hourHandAngle = 0;

  //是否已经绘制了背景
  bool _isDrawClock = false;

  LoadingView(this.animation,{Color color}) : this._defaultColor = color;

  @override
  void paint(Canvas canvas, Size size) {
    initPaint();

    if (!_isDrawClock) {
      _drawClock(canvas);
    }

    //在圆内绘制指针，时针旋转的角度根据分针的旋转角度而定,分针旋转60度时针旋转1度
    _hourHandAngle = animation.value;

    //计算分针的位置
    var minuteHandPointX =
        (_defaultRadius - 15) * cos((_hourHandAngle * 2) * pi / 180);
    var minuteHandPointY =
        (_defaultRadius - 15) * sin((_hourHandAngle * 2) * pi / 180);

    //时针的旋转角度为分针旋转角度的1/60
    var hourHandPointX =
        (_defaultRadius - 23) * cos((_hourHandAngle) * pi / 180);
    var hourHandPointY =
        (_defaultRadius - 23) * sin((_hourHandAngle ) * pi / 180);

    //绘制时针的线
    canvas.drawLine(Offset(0, 0),
        Offset(hourHandPointX, hourHandPointY), _mPaint);
    //绘制分针的线
    canvas.drawLine(Offset(0, 0),
        Offset(minuteHandPointX, minuteHandPointY), _mPaint);
  }

  //绘制时钟背景,背景不会随着动画的改变而改变，只绘制一次就可以了
  void _drawClock(Canvas canvas) {
    //绘制一个圆
    canvas.drawCircle(
        Offset(0, 0), _defaultRadius, _mPaint);

    //在圆内的0，90，180，270度分别绘制时间的位置
    for (int i = 0; i < 4; i++) {
      //时间起始的位置在圆上
      var currentPointX = _defaultRadius * cos((i * 90) * pi / 180);
      var currentPointY = _defaultRadius * sin((i * 90) * pi / 180);

      //时间的终点位置为半径减去 10
      var finalPointX = (_defaultRadius - 7) * cos((i * 90) * pi / 180);
      var finalPointY = (_defaultRadius - 7) * sin((i * 90) * pi / 180);
      //绘制横线
      canvas.drawLine(Offset(currentPointX, currentPointY),
          Offset(finalPointX, finalPointY), _mPaint);
    }

    //在下面左右两边分别位置两条线
    var upholderAngle = 60;
    for (int i = 1; i < 3; i++) {
      var upholderPointX = _defaultRadius * cos((upholderAngle * i) * pi / 180);
      var upholderPointY = _defaultRadius * sin((upholderAngle * i) * pi / 180);

      var upholderFinalPointX =
          (_defaultRadius + 15) * cos((upholderAngle * i) * pi / 180);
      var upholderFinalPointY =
          (_defaultRadius + 15) * sin((upholderAngle * i) * pi / 180);

      canvas.drawLine(Offset(upholderPointX, upholderPointY),
          Offset(upholderFinalPointX, upholderFinalPointY), _mPaint);
    }

    _isDrawClock = true;
  }

  //初始化画笔操作
  void initPaint() {
    if (_mPaint == null) {
      _mPaint = new Paint();
      _mPaint.isAntiAlias = true;
      _mPaint.style = PaintingStyle.stroke;
      _mPaint.color = Colors.grey;
      _mPaint.strokeCap = StrokeCap.round;
      _mPaint.strokeJoin = StrokeJoin.round;
      _mPaint.strokeWidth = 5.0;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
