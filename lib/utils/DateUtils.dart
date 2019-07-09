import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
/**
 *日期处理类
 */

//返回日期 时：分：秒，如果日期是今天则返回今天
class DateUtils {
  static String updateTime(String time) {
    DateFormat dateFormat = DateFormat("MM-dd HH:mm");
    //格式化今天的时间
    DateFormat nowDateFormat = DateFormat("yyyy-MM-dd");
    if (nowDateFormat.format(formatTimeZone(null)) ==
        nowDateFormat.format(formatTimeZone(time))) {
      dateFormat = DateFormat("HH:mm");
      return "今天 ${dateFormat.format(formatTimeZone(time))}";
    }
    return dateFormat.format(formatTimeZone(time));
  }

  //将时间格式化为HH:mm
  /**
   * timeZone: 是否带有时区信息
   */
  static String formatHHMM(String time, {bool timeZone = true}) {
    DateFormat dateFormat = DateFormat("HH:mm");
    DateTime dateTime;
    if (timeZone) {
      dateTime = formatTimeZone(time);
    } else {
      dateTime = formatTimeWithFormatStr(time, "yyyy-MM-dd HH:mm:ss");
    }
    return dateFormat.format(dateTime);
  }

  //将带有时区的时间格式化为普通时间
  static DateTime formatTimeZone(String time) {
    if (time != null && time.isNotEmpty) {
      DateFormat format = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
      return format.parseUTC(time);
    } else {
      //返回当前时间
      return DateTime.now().toLocal();
    }
  }

  //将yyyy-MM-dd转换为DateTime
  static DateTime formatTime(String time) {
    if (time != null && time.isNotEmpty) {
      DateFormat format = DateFormat("yyyy-MM-dd");
      return format.parse(time);
    } else {
      //返回当前时间
      return DateTime.now().toLocal();
    }
  }

  //根据指定的格式化方法将时间格式化为DateTime
  static DateTime formatTimeWithFormatStr(String time, String formatStr) {
    if (time != null && time.isNotEmpty && formatStr != null) {
      DateFormat format = DateFormat(formatStr);
      return format.parse(time);
    } else {
      //返回当前时间
      return DateTime.now().toLocal();
    }
  }

  //根据指定的日期返回星期几
  static String formatWeek(String date) {
    if (date != null && date.isNotEmpty) {
      DateTime dateTime = formatTimeWithFormatStr(date, "yyyy-MM-dd");
      if (dateTime.day - (DateTime.now().toLocal()).day >= 1) {
        switch (dateTime.weekday) {
          case 0:
            return "Monday(周一)";
          case 1:
            return "Tuesday(周二)";
          case 2:
            return "Wednesday(周三)";
          case 3:
            return "Thursday(周四)";
          case 4:
            return "Friday(周五)";
          case 5:
            return "Saturday(周六)";
          case 6:
            return "Sunday(周日)";
          case 7:
            return "Monday(周一)";
          default:
            return "${dateTime.weekday}";
        }
      } else {
        return "Tomorrow(明天)";
      }
    }

    return "";
  }

  //将时间转换为MM-dd 包含今天
  static String formatMMdd(String time) {
    DateFormat resultFormat = DateFormat("MM-dd");
    DateFormat yearFormat = DateFormat("yyyy-MM-dd");

    if (yearFormat.format(formatTime(null)) ==
        yearFormat.format(formatTime(time))) {
      return "今天";
    }
    return resultFormat.format(formatTime(time));
  }
}
