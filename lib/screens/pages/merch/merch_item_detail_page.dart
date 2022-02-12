import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lamborghini/model/merch_item.dart';
import 'package:lamborghini/screens/components/app_bar_text_component.dart';
import 'package:lamborghini/screens/components/image_item.dart';
import 'package:lamborghini/screens/components/text_component.dart';

class MerchItemDetailPage extends StatelessWidget {
  const MerchItemDetailPage({Key? key, required this.merchItem})
      : super(key: key);
  final MerchItem merchItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: AppBarTextComponent(
          text: merchItem.itemName,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarousel(merchItem.imageUrls),
            const SizedBox(
              height: 20,
            ),
            _rowTextComponents(
              merchItem.itemName.toUpperCase(),
              merchItem.category,
              const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              const TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.italic,
                color: Colors.white54,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            _rowTextComponents(
              "${merchItem.cost.toString()} PTS",
              merchItem.discount != null && merchItem.discount!= 0.0
                  ? "${merchItem.discount.toString()} PTS"
                  : "",
              const TextStyle(
                fontSize: 24.0,
                fontStyle: FontStyle.italic,
                color: Colors.redAccent,
              ),
              const TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
                color: Colors.white54,
                decoration: TextDecoration.lineThrough
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              merchItem.description,
              style: const TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
                color: Colors.white54,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCarousel(List<String> images) {
    return CarouselSlider(
      items: images.map<Widget>((i) {
        return Builder(
          builder: (BuildContext context) {
            return ImageItem(imageUrl: i);
          },
        );
      }).toList(),
      options: CarouselOptions(
        height: 250.0,
        enlargeCenterPage: true,
        autoPlay: true,
        autoPlayAnimationDuration: const Duration(seconds: 3),
        scrollDirection: Axis.horizontal,
        autoPlayCurve: Curves.fastOutSlowIn,
        viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
      ),
    );
  }

  Widget _rowTextComponents(String primaryString, String secondaryString,
      TextStyle primaryStyle, TextStyle secondaryStyle) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        TextComponent(
          text: primaryString,
          textStyle: primaryStyle,
        ),
        const SizedBox(
          width: 10,
        ),
        TextComponent(
          text: secondaryString,
          textStyle: secondaryStyle,
        )
      ],
    );
  }
}
