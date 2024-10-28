import 'package:flutter/material.dart';
import 'package:trilhaapp/Page/configuracoes_page.dart';
import 'package:trilhaapp/Page/dados_cadastrais.dart';
import 'package:trilhaapp/Page/login_page.dart';
import 'package:trilhaapp/Page/numeros_aleatorios/numeros_aleatorios_hive.dart';
import 'package:trilhaapp/Page/numeros_aleatorios/numeros_aleatorios_shared_preferences.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                child: Image.network(
                    "https://hermes.digitalinnovation.one/assets/diome/logo.png"),
              ),
              accountName: Text("Guipaiter"),
              accountEmail: Text("email@email.com")),
          InkWell(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Dados cadastrais"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CadastroPage(
                          texto: "Meus dados cadastrais",
                          dados: ["Nome", "Endereço"],
                        )),
              );
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.info),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Termos de uso e privacidade"),
                  ],
                )),
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext bc) {
                    return Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16, horizontal: 12),
                      child: const Column(
                        children: [
                          Text("Termos de uso e privacidade",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla rhoncus hendrerit leo at vehicula. Sed vel eros ligula. Sed dui felis, elementum nec scelerisque eu, vulputate sed nisl. Morbi dictum arcu sit amet leo iaculis cursus. Nulla a mi id eros commodo pulvinar. Phasellus sodales consectetur suscipit. In hac habitasse platea dictumst.",
                              textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 16)),
                        ],
                      ),
                    );
                  });
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.confirmation_number),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Gerador de números"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (bc) =>
                          const NumerosAleatoriosPageHive()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.album),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Configurações"),
                  ],
                )),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (bc) => const ConfiguracoesPage()));
            },
          ),
          const Divider(),
          const SizedBox(height: 10),
          InkWell(
            child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                width: double.infinity,
                child: const Row(
                  children: [
                    Icon(Icons.exit_to_app),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Sair"),
                  ],
                )),
            onTap: () {
              showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return AlertDialog(
                      alignment: Alignment.center,
                      elevation: 8,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      title: const Text("My app"),
                      content: const Wrap(
                        children: [
                          Text("Você sairá do aplicativo!"),
                          Text("Deseja sair do aplicativo?"),
                        ],
                      ),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text("Não")),
                        TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()));
                            },
                            child: const Text("Sim"))
                      ],
                    );
                  });
            },
          ),
        ],
      ),
    ));
  }
}
