import 'package:flutter/material.dart';
import 'package:lamborghini/model/merch_item.dart';
import 'package:lamborghini/screens/components/text_component.dart';

class MerchListItem extends StatelessWidget {
  const MerchListItem({
    Key? key,
    required this.item,
    required this.onPress,
  }) : super(key: key);
  final MerchItem item;
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
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextComponent(
                  text: item.itemName,
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
