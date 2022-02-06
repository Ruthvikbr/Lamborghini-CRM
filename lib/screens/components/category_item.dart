import 'package:flutter/material.dart';
import 'package:lamborghini/model/parent.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.parent, required this.onPress})
      : super(key: key);
  final Parent parent;
  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shadowColor: Colors.white,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: () => onPress(),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
            child: Ink.image(
              image: NetworkImage(
                parent.imageUrl,
              ),
              height: 200,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
