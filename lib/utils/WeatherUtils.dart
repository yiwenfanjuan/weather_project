//天气类工具类
class WeatherUtils {
  //根据不同的天气代码返回不同的天气图片
  static String checkWeatherImagePath(String weather_code) {
    String _weatherImagePath;
    switch (weather_code) {
      case "0":
      case "2":
        //白天晴天
        _weatherImagePath = "icons/icon_sunny_day.png";
        break;
      case "1":
      case "3":
        //夜间白天
        _weatherImagePath = "icons/icon_sunny_night.png";
        break;

      case "4":
        //多云
        _weatherImagePath = "icons/icon_cloudy.png";
        break;

      case "5":
        //白天晴间多云
        _weatherImagePath = "icons/icon_partly_cloudy_day.png";
        break;

      case "6":
        //晚上晴间多云
        _weatherImagePath = "icons/icon_partly_cloudy_night.png";
        break;
      case "7":
        //白天大部多云
        _weatherImagePath = "icons/icon_mostly_cloudy_day.png";
        break;
      case "8":
        //晚上大部多云
        _weatherImagePath = "icons/icon_mostly_cloudy_night.png";
        break;
      case "9":
        //阴
        _weatherImagePath = "icons/icon_overcast.png";
        break;
      case "10":
        //阵雨
        _weatherImagePath = "icons/icon_shower.png";
        break;
      case "11":
        //雷阵雨
        _weatherImagePath = "icons/icon_thundershower.png";
        break;
      case "12":
        //雷阵雨伴有冰雹
        _weatherImagePath = "icons/icon_thundershower_with_hail.png";
        break;
      case "13":
        //小雨
        _weatherImagePath = "icons/icon_light_rain.png";
        break;
      case "14":
        //中雨
        _weatherImagePath = "icons/icon_moderate_rain.png";
        break;
      case "15":
        //大雨
        _weatherImagePath = "icons/icon_heavy_rain.png";
        break;
      case "16":
        //暴雨
        _weatherImagePath = "icons/icon_storm.png";
        break;
      case "17":
        //大暴雨
        _weatherImagePath = "icons/icon_heavy_storm.png";
        break;
      case "18":
        //特大暴雨
        _weatherImagePath = "icons/icon_severe_storm.png";
        break;
      case "19":
        //冻雨
        _weatherImagePath = "icons/icon_ice_rain.png";
        break;
      case "20":
        //雨夹雪
        _weatherImagePath = "icons/icon_sleet.png";
        break;
      case "21":
        //阵雪
        _weatherImagePath = "icons/icon_snow_flurry.png";
        break;
      case "22":
        //小雪
        _weatherImagePath = "icons/icon_light_snow.png";
        break;
      case "23":
        //中雪
        _weatherImagePath = "icons/icon_moderate_snow.png";
        break;
      case "24":
        //大雪
        _weatherImagePath = "icons/icon_heavy_snow.png";
        break;
      case "25":
        //暴雪
        _weatherImagePath = "icons/icon_snowstorm.png";
        break;
      case "26":
        //浮尘
        _weatherImagePath = "icons/icon_dust.png";
        break;
      case "27":
        //扬沙
        _weatherImagePath = "icons/icon_sand.png";
        break;
      case "28":
        //沙尘暴
        _weatherImagePath = "icons/icon_duststorm.png";
        break;
      case "29":
        //强沙尘暴
        _weatherImagePath = "icons/icon_sandstorm.png";
        break;
      case "30":
        //雾
        _weatherImagePath = "icons/icon_foggy.png";
        break;
      case "31":
        //霾
        _weatherImagePath = "icons/icon_haze.png";
        break;
      case "32":
        //风
        _weatherImagePath = "icons/icon_windy.png";
        break;

      case "33":
        //大风
        _weatherImagePath = "icons/icon_blustery.png";
        break;
      case "34":
        //飓风
        _weatherImagePath = "icons/icon_hurricane.png";
        break;

      case "35":
        //热带风暴
        _weatherImagePath = "icons/icon_tropical_storm.png";
        break;

      case "36":
        //龙卷风
        _weatherImagePath = "icons/icon_tornado.png";
        break;

      case "37":
        //冷
        _weatherImagePath = "icons/icon_cold.png";
        break;

      case "38":
        //热
        _weatherImagePath = "icons/icon_hot.png";
        break;

      case "99":
        //未知天气类型
        _weatherImagePath = "icons/icon_unknown.png";
        break;
      default:
        //未知天气类型
        _weatherImagePath = "icons/icon_unknown.png";
        break;
    }
    return _weatherImagePath;
  }

  //根据不同的生活指数类型返回对应的文字
  static String getSuggestionText(String type) {
    String result = "";
    switch (type) {
      case "ac":
        result = "空调开启";
        break;
      case "air_pollution":
        result = "空气扩散";
        break;
      case "airing":
        result = "晾晒";
        break;
      case "allergy":
        result = "过敏";
        break;
      case "beer":
        result = "啤酒";
        break;
      case "boating":
        result = "划船";
        break;
      case "car_washing":
        result = "洗车";
        break;
      case "chill":
        result = "风寒";
        break;
      case "comfort":
        result = "舒适度";
        break;
      case "dating":
        result = "约会";
        break;
      case "dressing":
        result = "穿衣";
        break;
      case "fishing":
        result = "钓鱼";
        break;
      case "flu":
        result = "感冒";
        break;
      case "hair_dressing":
        result = "美发";
        break;
      case "kiteflying":
        result = "放风筝";
        break;
      case "makeup":
        result = "化妆";
        break;
      case "mood":
        result = "心情";
        break;
      case "morning_sport":
        result = "晨练";
        break;
      case "night_life":
        result = "夜生活";
        break;
      case "road_condition":
        result = "路况";
        break;
      case "shopping":
        result = "购物";
        break;
      case "sport":
        result = "运动";
        break;
      case "sunscreen":
        result = "防晒";
        break;
      case "traffic":
        result = "交通";
        break;
      case "travel":
        result = "旅游";
        break;
      case "umbrella":
        result = "雨伞";
        break;
      case "uv":
        result = "紫外线";
        break;
    }
    return result;
  }
}
