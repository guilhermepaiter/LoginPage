import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  List<String> linguagensSelecionadas = [];
  var nivelSelecionado = "";
  double salarioEscolido = 0;
  int tempoExperiencia = 0;
  late SharedPreferences storage;
  final String Chave_Dados_Cadastrais_Nome = "Chave_Dados_Cadastrais_Nome";
  final String Chave_Dados_Cadastrais_Data_Nascimento =
      "have_Dados_Cadastrais_Data_Nascimento";
  final String Chave_Dados_Cadastrais_Nivel_Experiencia =
      "Chave_Dados_Cadastrais_Nivel_Experiencia";
  final String Chave_Dados_Cadastrais_Linguagens =
      "Chave_Dados_Cadastrais_Linguagens";
  final String Chave_Dados_Cadastrais_Tempo_Experiencia =
      "Chave_Dados_Cadastrais_Tempo_Experiencia";
  final String Chave_Dados_Cadastrais_Salario =
      "Chave_Dados_Cadastrais_Salario";

  bool salvando = false;

  @override
  void initState() {
    niveis = nivelRepository.retornaNiveis();
    linguagens = linguagensRepository.retornaLinguagens();
    super.initState();
    carregarDados();
  }

  carregarDados() async {
    storage = await SharedPreferences.getInstance();
    nomeController.text =
        storage.getString(Chave_Dados_Cadastrais_Nome) ?? "";
    dataNascimentoController.text =
        storage.getString(Chave_Dados_Cadastrais_Data_Nascimento) ?? "";
    dataNascimento = DateTime.parse(Chave_Dados_Cadastrais_Data_Nascimento);
    nivelSelecionado =
        storage.getString(Chave_Dados_Cadastrais_Nivel_Experiencia) ?? "";
    linguagensSelecionadas =
        storage.getStringList(Chave_Dados_Cadastrais_Linguagens) ?? [];
    tempoExperiencia =
        storage.getInt(Chave_Dados_Cadastrais_Tempo_Experiencia) ?? 0;
    salarioEscolido = storage.getDouble(Chave_Dados_Cadastrais_Salario) ?? 0;
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
                      onPressed: () async {
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

                        await storage.setString(
                            Chave_Dados_Cadastrais_Nome, nomeController.text);
                        await storage.setString(
                            Chave_Dados_Cadastrais_Data_Nascimento,
                            dataNascimento.toString());
                        await storage.setString(
                            Chave_Dados_Cadastrais_Nivel_Experiencia,
                            nivelSelecionado);
                        await storage.setStringList(
                            Chave_Dados_Cadastrais_Linguagens,
                            linguagensSelecionadas);
                        await storage.setInt(
                            Chave_Dados_Cadastrais_Tempo_Experiencia,
                            tempoExperiencia);
                        await storage.setDouble(
                            Chave_Dados_Cadastrais_Salario, salarioEscolido);

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
