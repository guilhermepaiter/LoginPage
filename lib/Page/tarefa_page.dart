import 'package:flutter/material.dart';
import 'package:trilhaapp/model/tarefa.dart';
import 'package:trilhaapp/repositories/tarefa_repository.dart';

class TarefaPage extends StatefulWidget {
  const TarefaPage({super.key});

  @override
  State<TarefaPage> createState() => _TarefaPageState();
}

class _TarefaPageState extends State<TarefaPage> {
  var tarefasRepository = TarefaRepository();
  var _tarefas = <Tarefa>[];
  var descricaoController = TextEditingController();
  var apenasNaoConcluido = false;

  @override
  void initState() {
    super.initState();
    obterTarefas();
  }

  void obterTarefas() async {
    if (apenasNaoConcluido) {
      _tarefas = await TarefaRepository().listarNaoConcluida();
    } else {
      _tarefas = await TarefaRepository().listar();
    }
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
                              await TarefaRepository().adicionar(
                                  Tarefa(descricaoController.text, false));
                              Navigator.pop(context);
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
                          await TarefaRepository().remove(tarefa.id);
                          obterTarefas();
                        },
                        key: Key(tarefa.id),
                        child: ListTile(
                            title: Text(tarefa.descricao),
                            trailing: Switch(
                              onChanged: (bool value) async {
                                await TarefaRepository()
                                    .alterar(tarefa.id, value);
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
