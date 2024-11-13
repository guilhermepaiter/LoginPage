import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/model/tarefa_hive_model.dart';
import 'package:trilhaapp/my_app.dart';
import 'package:path_provider/path_provider.dart' as path_provider;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

Map<int, String> scripts = {
  1: '''CREATE TABLE tarefas (
        id INT PRIMARY KEY AUTOINCREMENT,
        descricao TEXT,
        concluido INTEGER
  );'''
};

Future iniciarDataBase() async {
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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var documentsDirectory =
      await path_provider.getApplicationDocumentsDirectory();
  Hive.init(documentsDirectory.path);
  Hive.registerAdapter(DadosCadastraisModelAdapter());
  Hive.registerAdapter(TarefaHiveModelAdapter());
  runApp(const MyApp());
}
