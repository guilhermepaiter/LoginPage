import 'package:trilhaapp/model/tarefa_model_sqlite.dart';
import 'sqlite_database.dart';

class TarefaSQLitRepository {
  Future<List<TarefaSQLiteModel>> obterDados(bool apenasNaoConcluidos) async {
    List<TarefaSQLiteModel> tarefas = [];
    var db = await SQLiteDatabase().obterDatabase();
    var result = await db.rawQuery(apenasNaoConcluidos
        ? "SELECT id, descricao, concluido FROM tarefas WHERE concluido = 0"
        : 'SELECT id, descricao, concluido FROM tarefas');
    for (var element in result) {
      tarefas.add(TarefaSQLiteModel(int.parse(element["id"].toString()),
          element["descricao"].toString(), element["concluido"] == 1));
    }
    return tarefas;
  }

  Future<void> salvar(TarefaSQLiteModel tarefaSQLiteModel) async {
    var db = await SQLiteDatabase().obterDatabase();
    db.rawInsert('INSERT INTO tarefas (descricao, concluido) values(?,?)',
        [tarefaSQLiteModel.descricao, tarefaSQLiteModel.concluido]);
  }

  Future<void> update(TarefaSQLiteModel tarefaSQLiteModel) async {
    var db = await SQLiteDatabase().obterDatabase();
    await db.rawInsert(
        'UPDATE tarefas SET descricao = ?, concluido = ? WHERE id = ?', [
      tarefaSQLiteModel.descricao,
      tarefaSQLiteModel.concluido,
      tarefaSQLiteModel.id
    ]);
  }

  Future<void> remove(int id) async {
    var db = await SQLiteDatabase().obterDatabase();
    await db.rawInsert('DELETE FROM tarefas WHERE id = ?', [id]);
  }
}
