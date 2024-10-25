import 'package:shared_preferences/shared_preferences.dart';

enum Storage_Chaves {
  Chave_Dados_Cadastrais_Nome,
  Chave_Dados_Cadastrais_Data_Nascimento,
  Chave_Dados_Cadastrais_Nivel_Experiencia,
  Chave_Dados_Cadastrais_Linguagens,
  Chave_Dados_Cadastrais_Tempo_Experiencia,
  Chave_Dados_Cadastrais_Salario,
  Chave_Nome_Usuario,
  Chave_Altura,
  Chave_Receber_Notificacao,
  Chave_Tema_Escuro,
  Chave_Numero_Aleatorio,
  Chave_Numero_Cliques
}

class AppStorageService {
  Future<void> setNumeroCliques(int value) async {
    await _setInt(Storage_Chaves.Chave_Numero_Cliques.toString(), value);
  }

  Future<int> getNumeroCliques() async {
    return _getInt(Storage_Chaves.Chave_Numero_Cliques.toString());
  }

  Future<void> setNumeroAleatorio(int value) async {
    await _setInt(Storage_Chaves.Chave_Numero_Aleatorio.toString(), value);
  }

  Future<int> getNumeroAleatorio() async {
    return _getInt(Storage_Chaves.Chave_Numero_Aleatorio.toString());
  }

  Future<void> setConfiguracoesTema(bool value) async {
    await _setBool(Storage_Chaves.Chave_Tema_Escuro.toString(), value);
  }

  Future<bool> getConfiguracoesTema() async {
    return _getBool(Storage_Chaves.Chave_Tema_Escuro.toString());
  }

  Future<void> setConfiguracoesReceberNotificacao(bool value) async {
    await _setBool(Storage_Chaves.Chave_Receber_Notificacao.toString(), value);
  }

  Future<bool> getConfiguracoesReceberNotificacao() async {
    return _getBool(Storage_Chaves.Chave_Receber_Notificacao.toString());
  }

  Future<void> setConfiguracoesAltura(double value) async {
    await _setDouble(Storage_Chaves.Chave_Altura.toString(), value);
  }

  Future<double> getConfiguracoesAltura() async {
    return _getDouble(Storage_Chaves.Chave_Altura.toString());
  }

  Future<void> setConfiguracoesNomeUsuario(String nome) async {
    await _setString(Storage_Chaves.Chave_Nome_Usuario.toString(), nome);
  }

  Future<String> getConfiguracoesNomeUsuario() async {
    return _getString(Storage_Chaves.Chave_Nome_Usuario.toString());
  }

  Future<void> setDadosCadastraisNome(String nome) async {
    await _setString(Storage_Chaves.Chave_Dados_Cadastrais_Nome.toString(), nome);
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(Storage_Chaves.Chave_Dados_Cadastrais_Nome.toString());
  }

  Future<void> setDadosCadastraisDataNascimento(DateTime data) async {
    await _setString(Storage_Chaves.Chave_Dados_Cadastrais_Data_Nascimento.toString(), data.toString());
  }

  Future<String> getDadosCadastraisDataNascimento() async {
    return _getString(Storage_Chaves.Chave_Dados_Cadastrais_Data_Nascimento.toString());
  }
  
  Future<void> setDadosCadastraisExperiencia(String data) async {
    await _setString(Storage_Chaves.Chave_Dados_Cadastrais_Nivel_Experiencia.toString(), data.toString());
  }

  Future<String> getDadosCadastraisExperiencia() async {
    return _getString(Storage_Chaves.Chave_Dados_Cadastrais_Nivel_Experiencia.toString());
  }

  Future<void> setDadosCadastraisLinguagens(List<String> values) async {
    await _setStringList(Storage_Chaves.Chave_Dados_Cadastrais_Linguagens.toString(), values);
  }

  Future<List<String>> getDadosCadastraisLinguagens() async {
    return _getStringList(Storage_Chaves.Chave_Dados_Cadastrais_Linguagens.toString());
  }

  Future<void> setDadosCadastraisTempoExperiencia(int values) async {
    await _setInt(Storage_Chaves.Chave_Dados_Cadastrais_Tempo_Experiencia.toString(), values);
  }

  Future<int> getDadosCadastraisTempoExperiencia() async {
    return _getInt(Storage_Chaves.Chave_Dados_Cadastrais_Tempo_Experiencia.toString());
  }

  Future<void> setDadosCadastraisSalario(double values) async {
    await _setDouble(Storage_Chaves.Chave_Dados_Cadastrais_Salario.toString(), values);
  }

  Future<double> getDadosCadastraisSalario() async {
    return _getDouble(Storage_Chaves.Chave_Dados_Cadastrais_Salario.toString());
  }

  _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }

  _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setStringList(chave, values);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    await storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }
}
