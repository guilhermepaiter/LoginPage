import 'dart:math';

import 'package:flutter/material.dart';
import 'package:trilhaapp/services/app_storage_service.dart';

class NumerosAleatoriosPageSharedPreferences extends StatefulWidget {
  const NumerosAleatoriosPageSharedPreferences({super.key});

  @override
  State<NumerosAleatoriosPageSharedPreferences> createState() =>
      _NumerosAleatoriosPageSharedPreferencesState();
}

class _NumerosAleatoriosPageSharedPreferencesState
    extends State<NumerosAleatoriosPageSharedPreferences> {
  int numeroGerado = 0;
  int numeroCliques = 0;
  AppStorageService storage = AppStorageService();

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    numeroGerado = await storage.getNumeroAleatorio();
    numeroCliques = await storage.getNumeroCliques();
    setState(() {});
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
                numeroGerado.isNaN
                    ? "Nenhum número gerado"
                    : numeroGerado.toString(),
                style: TextStyle(fontSize: 22),
              ),
              Text(
                numeroCliques.isNaN
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
                numeroCliques = numeroCliques + 1;
              });
              storage.setNumeroAleatorio(numeroGerado);
              storage.setNumeroCliques(numeroCliques);
            }),
      ),
    );
  }
}
