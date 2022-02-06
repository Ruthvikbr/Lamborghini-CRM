import 'package:flutter/material.dart';
import 'package:lamborghini/model/car.dart';
import 'package:lamborghini/screens/components/car_image_item.dart';
import 'package:lamborghini/screens/components/text_component.dart';

class CarItem extends StatelessWidget {
  const CarItem({Key? key, required this.car, required this.onPress})
      : super(key: key);
  final Car car;
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
          onTap: onPress,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CarImageItem(
                imageUrl: car.imageUrl,
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
