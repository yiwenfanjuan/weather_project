import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
/**
 * 数据库操作类
 */

class DBUtils {
  //location表名
  static const String TABLE_LOCATION = "locationTable";

  _DataBaseHelper dbHelper;

  DBUtils(){
    dbHelper = _DataBaseHelper();
  }



 //查询数据
  Future<List<Map<String, dynamic>>> queryData(String tableName,
      {String where, List arguments}) async {

    if(dbHelper._db == null){
      await dbHelper._initDatabase();
    }
  
    var result = await dbHelper._db.transaction((transcation) async{
      return transcation.query(tableName,where: where,whereArgs: arguments);
    });
    
    print("数据库中的数据:${result.runtimeType}");
    return result;
  }

  //添加数据到数据库
  Future<List<dynamic>> insertData(String table,Map<String,dynamic> data) async{
    if(dbHelper._db == null){
      await dbHelper._initDatabase();
    }
    Batch batch = dbHelper._db.batch();
    batch.insert(table, data);
    var result = batch.commit();
    return result;
  }


 
}


//数据库单例模式
class _DataBaseHelper{
//数据库名称
  static const String DB_NAME = "location.db";
  //数据库路径
  String _databasePath;
  //数据库真实路径
  String _path;

  //数据库信息
  Database _db;

  static _DataBaseHelper _helper = _DataBaseHelper._interval();

  _DataBaseHelper._interval();

  factory _DataBaseHelper() => _helper;

  //初始化数据库信息
  _initDatabase() async {
    _databasePath = await getDatabasesPath();
    _path = join(_databasePath, DB_NAME);
    //创建数据库
    if (!await databaseExists(_path)) {
      print("数据库不存在");
      try {
        await Directory(_databasePath).create(recursive: true);
        await _openDatabase();
      } catch (exception) {
        print("创建数据库时出错:${exception}");
      }
    }else{
      await _openDatabase();
    }
  }


   //打开数据库
  _openDatabase() async {
    _db = await openDatabase(_path, version: 1,
        onCreate: (Database db, int version) async {
      await db.transaction((transaction) async {
        await transaction.execute(
            "CREATE TABLE ${DBUtils.TABLE_LOCATION} (columnId INTEGER PRIMARY KEY AUTOINCREMENT,name TEXT NOT NULL,path TEXT)");
      });
    });
    print("打开数据库完成：$_db");
  }





  //从表中删除一条数据
  Future<int> deleteData(String tableName, String where, List arguments) async {
    return await _db.transaction<int>((transcation) async => await transcation
        .delete(tableName, where: where, whereArgs: arguments));
  }

  //更新一条数据信息
  Future<int> updateData(String tableName, Map<String, dynamic> values) async {
    return await _db.transaction((transaction) async {
      return await transaction.update(tableName, values);
    });
  }

}
