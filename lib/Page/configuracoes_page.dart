import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class ConfiguracoesPage extends StatefulWidget {
  const ConfiguracoesPage({super.key});

  @override
  State<ConfiguracoesPage> createState() => _ConfiguracoesPageState();
}

class _ConfiguracoesPageState extends State<ConfiguracoesPage> {
  AppStorageService storage = AppStorageService();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  String? nomeUsuario;
  double? altura;
  bool receberNofitication = false;
  bool temaEscuro = false;

  @override
  void initState() {
    // TODO: implement ==
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    nomeUsuarioController.text = await storage.getConfiguracoesNomeUsuario();
    alturaController.text = (await storage.getConfiguracoesAltura()).toString();
    receberNofitication = await storage.getConfiguracoesReceberNotificacao();
    temaEscuro = await storage.getConfiguracoesTema();
    setState(() {});
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
                        await storage.setConfiguracoesAltura(
                            double.parse(alturaController.text));
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
                      await storage.setConfiguracoesNomeUsuario(
                          nomeUsuarioController.text);
                      await storage.setConfiguracoesReceberNotificacao(
                          receberNofitication);
                      await storage.setConfiguracoesTema(temaEscuro);
                      Navigator.pop(context);
                    },
                    child: Text("Salvar"))
              ],
            ))));
  }
}
