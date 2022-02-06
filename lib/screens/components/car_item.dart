import 'package:flutter/material.dart';
import 'package:lamborghini/model/car.dart';
import 'package:lamborghini/screens/components/text_component.dart';

class CarItem extends StatelessWidget {
  const CarItem({Key? key, required this.car}) : super(key: key);
  final Car car;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Ink.image(
                image: NetworkImage(
                  car.imageUrl,
                ),
                height: 200,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextComponent(
                  text: car.modelName.toUpperCase(),
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
