import 'package:sqflite/sqlite_api.dart' as prefix0;

/**
 * 数据库数据事件改变的事件
 */

typedef void DatabaseChangeCallback(arg);

var databaseChangeEvent = DatabaseChangeEvent();

class DatabaseChangeEvent{
  //私有构造函数
  DatabaseChangeEvent._internal();

  //事件单例
  static DatabaseChangeEvent _singleton = DatabaseChangeEvent._internal();

  //工厂构造函数
  factory DatabaseChangeEvent() => _singleton;

  //当前订阅的事件队列
  var _emp = Map<Object,List<DatabaseChangeCallback>>();

  //添加订阅者
  void addCallback(eventName,DatabaseChangeCallback callback){
    if(eventName == null || callback == null){
      return;
    }
    _emp[eventName] ??= List<DatabaseChangeCallback>();
    _emp[eventName].add(callback);
  }

  //移除订阅者
  void removeCallback(eventName,[DatabaseChangeCallback callback]){
    var list = _emp[eventName];
    if(eventName == null || list == null){
      return;
    }
    if(callback == null){
      _emp[eventName] = null;
    }else{
      _emp[eventName].remove(callback);
    }
  }

  //触发事件，事件触发后该事件的所有订阅者会被调用
  void commit(eventName,arg){
    var list = _emp[eventName];
    if(list == null){
      return;
    }
    Iterator<DatabaseChangeCallback> iterator = list.iterator;
    while(iterator.moveNext()){
      DatabaseChangeCallback callback = iterator.current;
      callback(arg);
    }
  }
}


