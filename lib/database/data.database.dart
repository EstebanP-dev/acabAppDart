import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:acab_app/models/Data.dart';

class DatabaseHelper {
  static DatabaseHelper _databaseHelper;
  static Database _database;

  String tableData = 'data';
  String colId = 'id';
  String colApto = 'apto';
  String colActivity = 'activity';
  String colProgress = 'progress';
  String colDate = 'date';

  DatabaseHelper._createInstance();

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'zanetti.db';

    var zanettiDb = await openDatabase(path, version: 1, onCreate: _createDb);
    return zanettiDb;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $tableData($colId INTEGER PRIMARY KEY, $colApto TEXT, $colActivity TEXT, $colProgress INTEGER, $colDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getZanettiMapList() async {
    Database db = await this.database;

    var result = await db.query(tableData, orderBy: '$colApto ASC');
    return result;
  }

  Future<int> insertData(Data data) async {
    Database db = await this.database;
    var result = await db.insert(tableData, data.toMap());
    return result;
  }

  Future<int> updateData(Data data) async {
    var db = await this.database;
    var result = await db.update(tableData, data.toMap(),
        where: '$colId = ?', whereArgs: [data.id]);
    return result;
  }

  Future<int> deleteData(int id) async {
    var db = await this.database;
    int result =
        await db.rawDelete('DELETE FROM $tableData WHERE $colId = $id');
    return result;
  }

  Future<int> getCount() async {
    Database db = await this.database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) FROM $tableData');
    int result = Sqflite.firstIntValue(x);
    return result;
  }

  Future<List<Data>> getDataList() async{
    var dataMapList = await getZanettiMapList();
    int count = dataMapList.length;

    // ignore: deprecated_member_use
    List<Data> dataList = List<Data>();
    for(int i=0; i < count; i++){
      dataList.add(Data.fromMapObject(dataMapList[i]));
    }
    return dataList;
  }
}

