import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:weather_project/ui/loading_view.dart';

class LoadingDialogWidget extends StatefulWidget {
  @override
  _LoadingDialogState createState() {
    return _LoadingDialogState();
  }
}

class _LoadingDialogState extends State<LoadingDialogWidget>
    with SingleTickerProviderStateMixin {
  //动画控制器
  AnimationController _controller;
  //动画
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    //初始化动画控制器
    _controller =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    _animation = Tween(begin: 0.0, end: 360.0).animate(_controller);
    startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    Duration insetAnimationDuration = const Duration(milliseconds: 100);
    Curve insetAnimationCurve = Curves.decelerate;

    RoundedRectangleBorder _defaultDialogShape = RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(2.0)));

    return AnimatedPadding(
      padding: MediaQuery.of(context).viewInsets +
          const EdgeInsets.symmetric(horizontal: 40.0, vertical: 24.0),
      duration: insetAnimationDuration,
      curve: insetAnimationCurve,
      child: MediaQuery.removeViewInsets(
        removeBottom: true,
        removeLeft: true,
        removeRight: true,
        removeTop: true,
        context: context,
        child: Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Material(
              elevation: 24.0,
              shape: _defaultDialogShape,
              color: Theme.of(context).dialogBackgroundColor,
              type: MaterialType.card,
              child: Center(
                child: CustomPaint(
                  painter: LoadingView(_animation),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  //在子线程执行动画
  Future<Null> startAnimation() async {
    _animation.addListener(() {
      setState(() {});
    });

    await _controller.repeat();
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
