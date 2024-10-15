import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NumerosAleatoriosPage extends StatefulWidget {
  const NumerosAleatoriosPage({super.key});

  @override
  State<NumerosAleatoriosPage> createState() => _NumerosAleatoriosPageState();
}

class _NumerosAleatoriosPageState extends State<NumerosAleatoriosPage> {
  int? numeroGerado = 0;
  int? numeroCliques = 0;
  final chave_numero_aleatorio = "número aleatorio";
  final chave_numero_cliques = "númeroo de cliques";
  late SharedPreferences storage;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    storage = await SharedPreferences.getInstance();
    setState(() {
      numeroGerado = storage.getInt(chave_numero_aleatorio);
      numeroCliques = storage.getInt(chave_numero_cliques);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Gerador de numeros aleatóorioos"),
        ),
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                numeroGerado == null
                    ? "Nenhum número gerado"
                    : numeroGerado.toString(),
                style: TextStyle(fontSize: 22),
              ),
              Text(
                numeroCliques == null
                    ? "Nenhum clique efetuado"
                    : numeroCliques.toString(),
                style: TextStyle(fontSize: 22),
              )
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () async {
              var random = Random();
              setState(() {
                numeroGerado = random.nextInt(1000);
                numeroCliques = (numeroCliques ?? 0) + 1;
              });
              storage.setInt(chave_numero_aleatorio, numeroGerado!);
              storage.setInt(chave_numero_cliques, numeroCliques!);
            }),
      ),
    );
  }
}
