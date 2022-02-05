import 'package:flutter/material.dart';
import 'package:lamborghini/model/parent.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({Key? key, required this.parent}) : super(key: key);
  final Parent parent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shadowColor: Colors.black,
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        child: InkWell(
          onTap: () {},
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
