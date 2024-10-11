import 'package:flutter/material.dart';
import 'package:trilhaapp/widgets/app_images.dart';

class ListViewH extends StatefulWidget {
  const ListViewH({super.key});

  @override
  State<ListViewH> createState() => _ListViewHState();
}

class _ListViewHState extends State<ListViewH> {
  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      ListTile(
          leading: Image.asset(AppImages.vergil),
          title: Text("Usuário 2"),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Whats up bro?\n Lets battle again?"),
              Text("16:40")
            ],
          ),
          isThreeLine: true,
          trailing: PopupMenuButton<String>(onSelected: (menu) {
            print(menu);
          }, itemBuilder: (BuildContext bc) {
            return <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                  value: "Battle with Him", child: Text("Battle with Him!")),
              PopupMenuItem<String>(
                  value: "oIgnore Vergil and relax", child: Text("Ignore Vergil and relax!")),
              PopupMenuItem<String>(
                  value: "Go to the Vergil and kick him of the chair and drink your drink",
                  child: Text(
                      "Go to the Vergil and kick him of the chair!")),
            ];
          })),
      Image.asset(AppImages.dante),
      Image.asset(AppImages.vergil),
      Image.asset(AppImages.cenario1),
      Image.asset(AppImages.cenario2),
    ]);
  }
}
