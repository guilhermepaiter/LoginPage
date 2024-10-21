import 'package:shared_preferences/shared_preferences.dart';

enum Storage_Chaves {
  Chave_Dados_Cadastrais_Nome,
  Chave_Dados_Cadastrais_Data_Nascimento,
  Chave_Dados_Cadastrais_Nivel_Experiencia,
  Chave_Dados_Cadastrais_Linguagens,
  Chave_Dados_Cadastrais_Tempo_Experiencia,
  Chave_Dados_Cadastrais_Salario
}

class AppStorageService {
  void setDadosCadastraisNome(String nome) async {
    _setString(Storage_Chaves.Chave_Dados_Cadastrais_Nome.toString(), nome);
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(Storage_Chaves.Chave_Dados_Cadastrais_Nome.toString());
  }

  void setDadosCadastraisDataNascimento(DateTime data) async {
    _setString(Storage_Chaves.Chave_Dados_Cadastrais_Data_Nascimento.toString(), data.toString());
  }

  Future<String> getDadosCadastraisDataNascimento() async {
    return _getString(Storage_Chaves.Chave_Dados_Cadastrais_Data_Nascimento.toString());
  }
  
  void setDadosCadastraisDataExperiencia(String data) async {
    _setString(Storage_Chaves.Chave_Dados_Cadastrais_Nivel_Experiencia.toString(), data.toString());
  }

  Future<String> getDadosCadastraisDataExperiencia() async {
    return _getString(Storage_Chaves.Chave_Dados_Cadastrais_Nivel_Experiencia.toString());
  }

  void setDadosCadastraisLinguagens(List<String> values) async {
    _setStringList(Storage_Chaves.Chave_Dados_Cadastrais_Linguagens.toString(), values);
  }

  Future<List<String>> getDadosCadastraisLinguagens() async {
    return _getStringList(Storage_Chaves.Chave_Dados_Cadastrais_Linguagens.toString());
  }

  void setDadosCadastraisTempoExperiencia(int values) async {
    _setInt(Storage_Chaves.Chave_Dados_Cadastrais_Tempo_Experiencia.toString(), values);
  }

  Future<int> getDadosCadastraisTempoExperiencia() async {
    return _getInt(Storage_Chaves.Chave_Dados_Cadastrais_Tempo_Experiencia.toString());
  }

  void setDadosCadastraisSalario(double values) async {
    _setDouble(Storage_Chaves.Chave_Dados_Cadastrais_Salario.toString(), values);
  }

  Future<double> getDadosCadastraisSalario() async {
    return _getDouble(Storage_Chaves.Chave_Dados_Cadastrais_Salario.toString());
  }

  _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    storage.setStringList(chave, values);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }
}
