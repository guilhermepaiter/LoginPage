import 'package:flutter/material.dart';
import 'package:trilhaapp/model/configuracoes_model.dart';
import 'package:trilhaapp/repositories/configuracoes_repository.dart';

class ConfiguracoesHivePage extends StatefulWidget {
  const ConfiguracoesHivePage({super.key});

  @override
  State<ConfiguracoesHivePage> createState() => _ConfiguracoesHivePageState();
}

class _ConfiguracoesHivePageState extends State<ConfiguracoesHivePage> {
  late ConfiguracoesRepository configuracoesRepository;
  var configuracoesModel = ConfiguracoesModel.vazio();

  TextEditingController nomeUsuarioController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    configuracoesRepository = await configuracoesRepository.load();
    configuracoesModel = configuracoesRepository.obterDados();
    nomeUsuarioController.text = configuracoesModel.nomeUsuario;
    alturaController.text = configuracoesModel.altura.toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Configurações"),
            ),
            body: Container(
                child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    decoration: const InputDecoration(
                      hintText: "Nome Usuário",
                    ),
                    controller: nomeUsuarioController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: "Altura"),
                    controller: alturaController,
                  ),
                ),
                SwitchListTile(
                    title: const Text("Receber Notificações"),
                    value: configuracoesModel.receberNotificacao,
                    onChanged: (bool value) {
                      setState(() {
                        configuracoesModel.receberNotificacao =
                            configuracoesModel.receberNotificacao;
                      });
                    }),
                SwitchListTile(
                    title: const Text("Tema escuro"),
                    value: configuracoesModel.temaEscuro,
                    onChanged: (bool value) {
                      setState(() {
                        configuracoesModel.temaEscuro = value;
                      });
                    }),
                TextButton(
                    onPressed: () async {
                      FocusManager.instance.primaryFocus?.unfocus();
                      try {
                        configuracoesModel.altura =
                            double.parse(alturaController.text);
                      } catch (e) {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                  title: const Text("Meu App"),
                                  content: const Text(
                                      "Favor informar uma altura válida!"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Ok"))
                                  ]);
                            });
                      }
                      configuracoesModel.nomeUsuario =
                          (nomeUsuarioController.text);
                      configuracoesRepository.salvar(configuracoesModel);
                      Navigator.pop(context);
                    },
                    child: const Text("Salvar"))
              ],
            ))));
  }
}
