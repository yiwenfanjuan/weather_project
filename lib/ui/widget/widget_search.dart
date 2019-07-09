import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * 通用的一些组件
 */
class SerachWidget extends StatelessWidget {
  //输入框控制器
  TextEditingController _controller;

  //背景颜色
  Color backColor = Colors.transparent;
  //搜索框默认提示的文字
  final String hintText;
  //搜索按钮颜色,默认白色
  Color searchBarColor = Colors.white;
  //默认高度,默认50.0
  num searchBarHeight = 50.0;
  //点击搜索按钮的回调方法
  final Function searchCallBack;

  SerachWidget(this.hintText, this.searchCallBack,
      {this.backColor, this.searchBarHeight, this.searchBarColor})
      : assert(searchCallBack != null) {
    _controller = new TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(height: searchBarHeight),
      color: backColor,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //输入框
          Expanded(
            flex: 1,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
                hintMaxLines: 1,
                border: InputBorder.none,
              ),
              textAlign: TextAlign.center,
              cursorColor: Colors.pinkAccent,
            ),
          ),
          //右边显示一个搜索按钮
          GestureDetector(
            child: Center(
              child: Icon(
                Icons.search,
                color: searchBarColor,
                size: 30.0,
              ),
            ),
            onTap: () {
              if (_controller != null) {
                searchCallBack(_controller.text);
              }
            },
          ),
        ],
      ),
    );
  }
}

//圆角的按钮
class RoundButtonWidget extends StatelessWidget {
  //按钮显示的文字
  final String text;
  //文字信息
  final TextStyle textStyle;

  //圆角的大小写
  final num roundSize;

  //padding信息
  final EdgeInsets paddingEdge;

  //背景颜色,默认透明色
  Color backColor = Colors.transparent;

  //外层Border的大小,默认没有
  num borderSize = 0;
  //外层border的颜色
  Color borderColor;

  //固定高度和宽度
  num width;
  num height;

  //渐变背景，默认没有
  Gradient gradient;

  RoundButtonWidget(this.text, this.textStyle, this.roundSize,
      {this.backColor,
      this.borderSize,
      this.borderColor,
      this.width,
      this.height,
      this.gradient,
      this.paddingEdge})
      : assert(text != null),
        assert(roundSize != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: width != null
          ? height != null
              ? BoxConstraints.expand(width: width, height: height)
              : BoxConstraints.tightFor(width: width)
          : BoxConstraints.tightFor(),
      padding: paddingEdge == null ? EdgeInsets.all(0) : paddingEdge,
      decoration: BoxDecoration(
        color: backColor,
        shape: BoxShape.rectangle,
        border: (borderSize == null || borderSize <= 0)
            ? null
            : Border.all(
                color: borderColor,
                width: borderSize,
              ),
        borderRadius: BorderRadius.circular(roundSize),
        gradient: gradient,
      ),
      child: Text(text,
        style: textStyle,
      ),
    );
  }
}
