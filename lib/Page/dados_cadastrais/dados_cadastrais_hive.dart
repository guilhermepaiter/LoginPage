import 'package:flutter/material.dart';
import 'package:trilhaapp/model/dados_cadastrais_model.dart';
import 'package:trilhaapp/repositories/dados_cadastrais_repository.dart';
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
  late DadosCadastraisRepository dadosCadastraisRepository;
  var dadosCadastraisModel = DadosCadastraisModel.vazio();
  var nomeController = TextEditingController(text: "");
  var dataNascimentoController = TextEditingController(text: "");
  var nivelRepository = NivelRepositories();
  var linguagensRepository = LinguagensRepository();
  var niveis = [];
  var linguagens = [];

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    dadosCadastraisRepository = await dadosCadastraisRepository.load();
    dadosCadastraisModel = dadosCadastraisRepository.obterDados();
    nomeController.text = dadosCadastraisModel.nome ?? "";
    dataNascimentoController.text = dadosCadastraisModel.dataNascimento == null
        ? ""
        : dadosCadastraisModel.dataNascimento.toString();
    setState(() {});
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
                            dadosCadastraisModel.dataNascimento = data;
                          }
                        }),
                    const TextLabel(texto: "Nivel de Conhecimento"),
                    Column(
                      children: niveis
                          .map((nivel) => RadioListTile(
                              dense: true,
                              title: Text(nivel.toString()),
                              selected: dadosCadastraisModel.nivelExperiencia ==
                                  nivel,
                              value: nivel.toString(),
                              groupValue: dadosCadastraisModel.nivelExperiencia,
                              onChanged: (value) {
                                print(value);
                                setState(() {
                                  dadosCadastraisModel.nivelExperiencia =
                                      value.toString();
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
                                value: dadosCadastraisModel.linguagem
                                    .contains(linguagem),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value!) {
                                      dadosCadastraisModel.linguagem
                                          .add(linguagem);
                                    } else {
                                      dadosCadastraisModel.linguagem
                                          .remove(linguagem);
                                    }
                                  });
                                }))
                            .toList()),
                    const TextLabel(texto: "Tempo de experiência"),
                    DropdownButton(
                      value: dadosCadastraisModel.tempoExperiencia,
                      isExpanded: true,
                      items: returnItens(50),
                      onChanged: (value) {
                        setState(() {
                          dadosCadastraisModel.tempoExperiencia =
                              int.parse(value.toString());
                        });
                      },
                    ),
                    TextLabel(
                        texto:
                            "Pretenção Salarial. R\$ ${dadosCadastraisModel.salario?.round().toString()}"),
                    Slider(
                      min: 0,
                      max: 10000,
                      value: dadosCadastraisModel.salario ?? 0,
                      onChanged: (double value) {
                        setState(() {
                          dadosCadastraisModel.salario = value;
                        });
                      },
                    ),
                    TextButton(
                      onPressed: () async {
                        if (nomeController.text.trim().length < 3) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("O nome deve ser preenchido!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.dataNascimento == null) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content:
                                Text("A data de Nascimento está inavlida!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.nivelExperiencia == null ||
                            dadosCadastraisModel.nivelExperiencia!.trim() ==
                                "") {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("O nivel deve ser selecionado!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.linguagem.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Deve ter pelo menos uma linguagem selecionada!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.tempoExperiencia == null ||
                            dadosCadastraisModel.tempoExperiencia == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "Deve ter pelo menos um ano de experiência em uma das linguaguens!"),
                          ));
                          return;
                        }
                        if (dadosCadastraisModel.salario == null ||
                            dadosCadastraisModel.salario == 0) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text(
                                "A pretenção salarial deve ser maior que 0!"),
                          ));
                          return;
                        }
                        dadosCadastraisModel.nome = nomeController.text;
                        dadosCadastraisRepository.salvar(dadosCadastraisModel);
                        setState(() {
                          salvando = true;
                        });
                        Future.delayed(Duration(seconds: 3), () {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Dados salvos com sucesso!"),
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
