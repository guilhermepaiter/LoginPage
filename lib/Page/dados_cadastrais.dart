import 'package:flutter/material.dart';
import 'package:trilhaapp/repositories/linguagens_repository.dart';
import 'package:trilhaapp/repositories/nivel_repositories.dart';
import 'package:trilhaapp/widgets/text_label.dart';

class CadastroPage extends StatefulWidget {
  final String texto;
  final List<String> dados;

  const CadastroPage({super.key, required this.texto, required this.dados});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  DateTime? dataNascimento;
  var nivelRepository = NivelRepositories();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];
  var linguagensSelecionadas = [];
  var nivelSelecionado = "";
  double salarioEscolido = 0;
  int tempoExperiencia = 0;

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
  }

  List<DropdownMenuItem<int>> returnItens(int quantidadeMaxima) {
    var itens = <DropdownMenuItem<int>>[];
    for (var i = 0; i <= quantidadeMaxima; i++) {
      itens.add(DropdownMenuItem(
        child: Text(i.toString()),
        value: i,
      ));
    }
    return itens;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.texto)),
        body: Padding(
          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: salvando
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  children: [
                    const TextLabel(texto: "Nome"),
                    TextField(
                      controller: nomeController,
                    ),
                    const TextLabel(texto: "Data de nascimento"),
                    TextField(
                        controller: dataNascimentoController,
                        readOnly: true,
                        onTap: () async {
                          var data = await showDatePicker(
                              context: context,
                              initialDate: DateTime(2000, 1, 1),
                              firstDate: DateTime(1900, 5, 20),
                              lastDate: DateTime(2024, 12, 31));
                          if (data != null) {
                            dataNascimentoController.text = data.toString();
                            dataNascimento = data;
                          }
                        }),
                    const TextLabel(texto: "Nivel de Conhecimento"),
                    Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              dense: true,
                              title: Text(nivel.toString()),
                              selected: nivelSelecionado == nivel,
                              value: nivel.toString(),
                              groupValue: nivelSelecionado,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  nivelSelecionado = value.toString();
                                });
                              }))
                          .toList(),
                    ),
                    const TextLabel(
                      texto: "Linguagens preferidade",
                    ),
                    Column(
                        children: linguagens
                            .map((linguagem) => CheckboxListTile(
                                dense: true,
                                title: Text(linguagem),
                                value:
                                    linguagensSelecionadas.contains(linguagem),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      linguagensSelecionadas.add(linguagem);
                                    } else {
                                      linguagensSelecionadas.remove(linguagem);
                                    }
                                  });
                                }))
                            .toList()),
                    const TextLabel(texto: "Tempo de experiência"),
                    DropdownButton(
                      value: tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(50),
                      onChanged: (value) {
                        setState(() {
                          tempoExperiencia = int.parse(value.toString());
                        });
                      },
                    ),
                    TextLabel(
                        texto:
                            "Pretenção Salarial. R\$ ${salarioEscolido.round().toString()}"),
                    Slider(
                      min: 0,
                      max: 10000,
                      value: salarioEscolido,
                      onChanged: (double value) {
                        setState(() {
                          salarioEscolido = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () {
                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("O nome deve ser preenchido!"),
                          ));
                          return;
                        }
                        if (dataNascimento == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("A data de Nascimento está inavlida!"),
                          ));
                          return;
                        }
                        if (nivelSelecionado.trim() == "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("O nivel deve ser selecionado!"),
                          ));
                          return;
                        }
                        if (linguagensSelecionadas.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Deve ter pelo menos uma linguagem selecionada!"),
                          ));
                          return;
                        }
                        if (tempoExperiencia == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Deve ter pelo menos um ano de experiência em uma das linguaguens!"),
                          ));
                          return;
                        }
                        if (salarioEscolido == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "A pretenção salarial deve ser maior que 0!"),
                          ));
                          return;
                        }
                        setState(() {
                          salvando = true;
                        });
                        Future.delayed(Duration(seconds: 3), () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Dados salvos com sucesso!"),
                          ));
                          setState(() {
                            salvando = false;
                          });
                          Navigator.pop(context);
                        });
                      },
                      child: const Text("Salvar"),
                    )
                  ],
                ),
        ));
  }
}
