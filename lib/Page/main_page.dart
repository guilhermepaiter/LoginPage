import 'package:flutter/material.dart';
import 'package:trilhaapp/Page/card_page.dart';
import 'package:trilhaapp/Page/image_assets.dart';

import 'package:trilhaapp/Page/list_view.dart';
import 'package:trilhaapp/Page/tarefa_page/tarefa_hive/tarefa_Hive_page.dart';
import 'package:trilhaapp/widgets/custom_drawer.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var controller = PageController(initialPage: 0);
  int posicaoPage = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Page Main"),
              backgroundColor: Colors.blue,
            ),
            drawer: CustomDrawer(),
            body: Column(children: [
              Expanded(
                child: PageView(
                  controller: controller,
                  onPageChanged: (value) {
                    setState(() {
                      posicaoPage = value;
                    });
                  },
                  scrollDirection: Axis.horizontal,
                  children: const [
                    CardPage(),
                    ImageAssetsPage(),
                    ListViewH(),
                    TarefaHivePage()
                  ],
                ),
              ),
              BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) {
                    controller.jumpToPage(value);
                  },
                  currentIndex: posicaoPage,
                  items: const [
                    BottomNavigationBarItem(
                        label: "Home", icon: Icon(Icons.home)),
                    BottomNavigationBarItem(
                        label: "ideias",
                        icon: Icon(Icons.catching_pokemon_sharp)),
                    BottomNavigationBarItem(
                        label: "Carrinho", icon: Icon(Icons.shopping_cart)),
                    BottomNavigationBarItem(
                        label: "Lista", icon: Icon(Icons.list))
                  ])
            ])));
  }
}
