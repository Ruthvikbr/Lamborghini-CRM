import 'package:flutter/material.dart';
import 'package:lamborghini/model/car.dart';
import 'package:lamborghini/screens/components/app_bar_text_component.dart';
import 'package:lamborghini/screens/components/image_item.dart';
import 'package:lamborghini/screens/components/text_component.dart';

class CarDetail extends StatelessWidget {
  const CarDetail({Key? key, required this.car}) : super(key: key);
  final Car car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppBarTextComponent(
          text: car.modelName,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              ImageItem(
                imageUrl: car.imageUrl,
                height: 250,
              ),
              const SizedBox(
                height: 20,
              ),
              TextComponent(
                text: car.modelName.toUpperCase(),
                textStyle: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextComponent(
                text: car.parentModelName,
                textStyle: const TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextComponent(
                text: "Overview",
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                car.overview,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontStyle: FontStyle.italic,
                  color: Colors.white54,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const TextComponent(
                text: "Specs",
                textStyle: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              carDetailsWidget("Power", car.power),
              const SizedBox(height: 10),
              carDetailsWidget("Max speed", car.maxSpeed),
              const SizedBox(height: 10),
              carDetailsWidget("0 - 100 km/h", car.zeroToHundredAcceleration),

            ],
          ),
        ),
      ),
    );
  }

  Widget carDetailsWidget(String heading, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextComponent(
          text: heading,
          textStyle: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
        TextComponent(
          text: value,
          textStyle: const TextStyle(
            fontSize: 16.0,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

}
