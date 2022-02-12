import 'package:flutter/material.dart';

class ImageItem extends StatelessWidget {
  const ImageItem({
    Key? key,
    required this.imageUrl,
    this.height = 200,
    this.fitType,
  }) : super(key: key);

  final String imageUrl;
  final double height;
  final BoxFit? fitType;

  @override
  Widget build(BuildContext context) {
    return Ink.image(
      image: NetworkImage(
        imageUrl,
      ),
      height: height,
      fit: fitType ?? BoxFit.cover,
    );
  }
}
