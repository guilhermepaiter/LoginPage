import 'package:flutter/material.dart';
import 'package:trilhaapp/widgets/app_images.dart';

class ListViewHorizontal extends StatefulWidget {
  const ListViewHorizontal({super.key});

  @override
  State<ListViewHorizontal> createState() => _ListViewHorizontalState();
}

class _ListViewHorizontalState extends State<ListViewHorizontal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Image.asset(AppImages.cenario1),
          Image.asset(AppImages.cenario2),
        ],
      ),
    ));
  }
}
