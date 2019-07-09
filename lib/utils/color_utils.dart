import 'dart:ui';

/**
 * 颜色相关的工具类
 */
class ColorUtils {
  //根据当前时间获取背景颜色
  static List<Color> getColorWithTime(){
    List<Color> colors = List();
    //获取当前时间
    int hour = DateTime.now().hour;
    
    if(hour > 6 && hour < 19){
      //白天F6D032 ~D85E00
      colors.clear();     
      colors.add(Color.fromARGB(255, 50, 209, 248));
      colors.add(Color.fromARGB(255, 0, 94, 216));
    }else{
      //晚上 96033E ~ 2E0703
      colors.clear();
      colors.add(Color.fromARGB(255, 64, 3, 153));
      colors.add(Color.fromARGB(255, 3, 7, 46));
    }
    return colors;
  }

  //根据时间获取城市背景图片
  static Color getCityBackgroundWithTime(){
    Color color;
    int hour = DateTime.now().hour;
    if(hour > 6 && hour < 19){
      color = Color.fromARGB(255, 84, 188, 241);
    }else{
      color = Color.fromARGB(255, 80, 48, 141);
    }
    return color;
  }
}