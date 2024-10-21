import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  late SharedPreferences storage;

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberNofitication = false;
  bool temaEscuro = false;

  final Chave_Nome_Usuario = "Chave_Nime_Usuario";
  final Chave_Altura = "Chave_Altuta";
  final Chave_Receber_Notificacao = "Chave_Receber_Notificacao";
  final Chave_Tema_Escuro = "Chave_Modo_Escuro";

  @override
  void initState() {
    // TODO: implement ==
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      nomeUsuarioController.text = storage.getString(Chave_Nome_Usuario) ?? "";
      alturaController.text = (storage.getDouble(Chave_Altura) ?? 0).toString();
      receberNofitication = storage.getBool(Chave_Receber_Notificacao) ?? false;
      temaEscuro = storage.getBool(Chave_Tema_Escuro) ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: Text("Configurações"),
            ),
            body: Container(
                child: ListView(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Nome Usuário",
                    ),
                    controller: nomeUsuarioController,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(hintText: "Altura"),
                    controller: alturaController,
                  ),
                ),
                SwitchListTile(
                    title: Text("Receber Notificações"),
                    value: receberNofitication,
                    onChanged: (bool value) {
                      setState(() {
                        receberNofitication = !receberNofitication;
                      });
                    }),
                SwitchListTile(
                    title: Text("Tema escuro"),
                    value: temaEscuro,
                    onChanged: (bool value) {
                      setState(() {
                        temaEscuro = value;
                      });
                    }),
                TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        await storage.setDouble(
                            Chave_Altura, double.parse(alturaController.text));
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                  title: Text("Meu App"),
                                  content:
                                      Text("Favor informar uma altura válida!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text("Ok"))
                                  ]);
                            });
                      }
                      await storage.setString(
                          Chave_Nome_Usuario, nomeUsuarioController.text);
                      await storage.setBool(
                          Chave_Receber_Notificacao, receberNofitication);
                      await storage.setBool(Chave_Tema_Escuro, temaEscuro);
                      Navigator.pop(context);
                    },
                    child: Text("Salvar"))
              ],
            ))));
  }
}
