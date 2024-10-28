import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class NumerosAleatoriosPageHive extends StatefulWidget {
  const NumerosAleatoriosPageHive({super.key});

  @override
  State<NumerosAleatoriosPageHive> createState() =>
      _NumerosAleatoriosPageHiveState();
}

class _NumerosAleatoriosPageHiveState extends State<NumerosAleatoriosPageHive> {
  int numeroGerado = 0;
  int numeroCliques = 0;
  late Box boxNumerosAleatorios;

  @override
  void initState() {
    super.initState();
    carregarDados();
  }

  void carregarDados() async {
    if(Hive.isBoxOpen('box_numeros_aleatorios')) {
      boxNumerosAleatorios = Hive.box('box_numeros_aleatorios');
    } else {
      boxNumerosAleatorios = await Hive.openBox('box_numeros_aleatorios');
    }
    numeroGerado = boxNumerosAleatorios.get('numeroGerado') ?? 0;
    numeroCliques = boxNumerosAleatorios.get('numeroCliques') ?? 0;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Hive"),
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
              boxNumerosAleatorios.put('numeroGerado', numeroGerado);
              boxNumerosAleatorios.put('numeroCliques', numeroCliques);
            }),
      ),
    );
  }
}
