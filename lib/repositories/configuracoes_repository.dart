import 'package:hive/hive.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';

class ConfiguracoesRepository {
  static late Box _box;

  ConfiguracoesRepository._create();

  Future<ConfiguracoesRepository> load() async {
    if (Hive.isBoxOpen('configuracoes')) {
      _box = Hive.box('Configuracoes');
    } else {
      _box = await Hive.openBox('configuracoes');
    }
    return ConfiguracoesRepository._create();
  }

  void salvar(ConfiguracoesModel configuracoesModel) {
    _box.put('dados', {
      'nomeUsuario': configuracoesModel.nomeUsuario,
      'altura': configuracoesModel.altura,
      'receberNotificacao': configuracoesModel.receberNotificacao,
      'temaEscuro': configuracoesModel.temaEscuro,
    });
  }

  ConfiguracoesModel obterDados() {
    var configuracoes = _box.get('Configuracoes');
    if (configuracoes == null) {
      return ConfiguracoesModel.vazio();
    }
    return ConfiguracoesModel(
        configuracoes['nomeUsuario'],
        configuracoes['altura'],
        configuracoes['receberNotificacao'],
        configuracoes['temaEscuro']);
  }
}
