import 'package:flutter/material.dart';

class CarImageItem extends StatelessWidget {
  const CarImageItem({Key? key, required this.imageUrl,this.height=200}) : super(key: key);

  final String imageUrl;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: NetworkImage(
        imageUrl,
      ),
      height: height,
      fit: BoxFit.cover,
    );
  }
}
