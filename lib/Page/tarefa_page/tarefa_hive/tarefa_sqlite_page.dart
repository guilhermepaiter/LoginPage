import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa_model_sqlite.dart';
import 'package:trilhaapp/repositories/sqlite/tarefa_sqlit_repository.dart';

class TarefaSQLitePage extends StatefulWidget {
  const TarefaSQLitePage({super.key});

  @override
  State<TarefaSQLitePage> createState() => _TarefaSQLitePageState();
}

class _TarefaSQLitePageState extends State<TarefaSQLitePage> {
  TarefaSQLitRepository tarefaRepository = TarefaSQLitRepository();
  var _tarefas = <TarefaSQLiteModel>[];
  var descricaoController = TextEditingController();
  var apenasNaoConcluido = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    _tarefas = await tarefaRepository.obterDados(apenasNaoConcluido);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            descricaoController.text = "";
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                      title: const Text("Adicionar tarefa"),
                      content: TextField(
                        controller: descricaoController,
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Cancelar")),
                        TextButton(
                            onPressed: () async {
                              await tarefaRepository.salvar(TarefaSQLiteModel(
                                  0, descricaoController.text, false));
                              Navigator.pop(context);
                              obterTarefas();
                              setState(() {});
                            },
                            child: const Text("Salvar"))
                      ]);
                });
          },
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Apenas não concluidos:",
                          style: TextStyle(fontSize: 18)),
                      Switch(
                          value: apenasNaoConcluido,
                          onChanged: (bool value) {
                            apenasNaoConcluido = value;
                            obterTarefas();
                          })
                    ],
                  )),
              Expanded(
                child: ListView.builder(
                    itemCount: _tarefas.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var tarefa = _tarefas[index];
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) async {
                          tarefaRepository.remove(tarefa.id);
                          obterTarefas();
                        },
                        key: Key(tarefa.descricao),
                        child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                tarefa.concluido = value;
                                tarefaRepository.update(tarefa);
                                obterTarefas();
                              },
                              value: tarefa.concluido,
                            )),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
