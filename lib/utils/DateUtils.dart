import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
/**
 *日期处理类
 */

//返回日期 时：分：秒，如果日期是今天则返回今天
class DateUtils{

  static String updateTime(String time){
    DateFormat dateFormat = DateFormat("MM-dd HH:mm");
    //格式化今天的时间
    DateFormat nowDateFormat = DateFormat("yyyy-MM-dd");
    if(nowDateFormat.format(formatTimeZone(null)) == nowDateFormat.format(formatTimeZone(time))){
      dateFormat = DateFormat("HH:mm");
      return "今天 ${dateFormat.format(formatTimeZone(time))}";
    }
    return dateFormat.format(formatTimeZone(time));
  }

  //将带有时区的时间格式化为普通时间
  static DateTime formatTimeZone(String time){
    if(time != null && time.isNotEmpty){
      DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
      return format.parseUTC(time);
    }else{
      //返回当前时间
      return DateTime.now().toLocal();
    }
  }

  //将yyyy-MM-dd转换为DateTime
  static DateTime formatTime(String time){
    if(time != null && time.isNotEmpty){
      DateFormat format = DateFormat("yyyy-MM-dd");
      return format.parse(time);
    }else{
      //返回当前时间
      return DateTime.now().toLocal();
    }
  }

  //将时间转换为MM-dd 包含今天
  static String formatMMdd(String time){
    
    DateFormat resultFormat = DateFormat("MM-dd");
    DateFormat yearFormat = DateFormat("yyyy-MM-dd");

    if(yearFormat.format(formatTime(null)) == yearFormat.format(formatTime(time))){
      return "今天";
    }
    return resultFormat.format(formatTime(time));
    
  }
}