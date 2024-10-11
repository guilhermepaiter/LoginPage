import 'package:flutter/material.dart';
import 'package:trilhaapp/widgets/app_images.dart';

class ImageAssetsPage extends StatefulWidget {
  const ImageAssetsPage({super.key});

  @override
  State<ImageAssetsPage> createState() => _ImageAssetsPageState();
}

class _ImageAssetsPageState extends State<ImageAssetsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AppImages.dante,
          height: 100,
      ),
      Image.asset(
        AppImages.vergil,
        height: 100,
      ),
      Image.asset(
        AppImages.cenario1,
        height: 100,
      ),
      Image.asset(
        AppImages.cenario2,
        height: 100,
      )
      ],
    );
  }
}