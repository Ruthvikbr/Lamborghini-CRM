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
  final Function(MerchItem) onPress;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
                child: Image.network(item.primaryDisplayImage)),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 4.0),
              child: TextComponent(
                text: item.itemName.toString(),
                textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
                textAlign: TextAlign.left,
                maxLines: 2,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextComponent(
                    text: "${item.cost.toString()} PTS",
                    textStyle:
                    const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextComponent(
                    text: item.discount != null && item.discount!= 0.0
                        ? "${item.discount.toString()} PTS"
                        : "",
                    textStyle: const TextStyle(
                        fontSize: 14.0,
                        fontStyle: FontStyle.normal,
                        color: Colors.black38,
                        decoration: TextDecoration.lineThrough),
                    textAlign: TextAlign.left,
                    maxLines: 1,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () => onPress(item),
    );
  }

}
