import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: '''CREATE TABLE tarefas (
        id INT PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        concluido INTEGER
  );'''
};

class SQLiteDatabase {
  static Database? db;

  Future<Database> obterDatabase() async {
    if (db == null) {
      return await iniciarDataBase();
    } else {
      return db!;
    }
  }

  Future<Database> iniciarDataBase() async {
    var db = await openDatabase(
        path.join(await getDatabasesPath(), 'database.db'),
        version: scripts.length, onCreate: (Database db, int version) async {
      for (var i = 1; i <= scripts.length; i++) {
        await db.execute(scripts[1]!);
        debugPrint(scripts[1]!);
      }
    }, onUpgrade: (Database db, int oldVersion, int newVersione) async {
      for (var i = oldVersion + 1; i <= scripts.length; i++) {
        await db.execute(scripts[1]!);
        debugPrint(scripts[1]!);
      }
    });
    return db;
  }
}
