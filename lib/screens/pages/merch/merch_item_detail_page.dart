import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lamborghini/blocs/merch_bloc.dart';
import 'package:lamborghini/model/merch_item.dart';
import 'package:lamborghini/model/simple_response.dart';
import 'package:lamborghini/model/transaction.dart';
import 'package:lamborghini/screens/components/app_bar_text_component.dart';
import 'package:lamborghini/screens/components/custom_button.dart';
import 'package:lamborghini/screens/components/image_item.dart';
import 'package:lamborghini/screens/components/text_component.dart';
import 'package:lamborghini/screens/pages/merch/merch_item_purchase_response_page.dart';
import 'package:lamborghini/services/shared_preferences.dart';

class MerchItemDetailPage extends StatelessWidget {
  const MerchItemDetailPage({
    Key? key,
    required this.merchItem,
    required this.bloc,
  }) : super(key: key);
  final MerchItem merchItem;
  final MerchBloc bloc;

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
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildCarousel(merchItem.imageUrls),
            const SizedBox(
              height: 20,
            ),
            _rowTextComponents(
              merchItem.itemName.toUpperCase(),
              merchItem.category,
              const TextStyle(
                fontSize: 22.0,
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
              merchItem.discount != null && merchItem.discount != 0.0
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
                  decoration: TextDecoration.lineThrough),
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
            const SizedBox(
              height: 30,
            ),
            CustomButton(
              child: TextComponent(
                text: merchItem.productAvailability
                    ? "Redeem"
                    : "Product currently unavailable",
                textStyle: const TextStyle(
                  fontSize: 14.0,
                  fontStyle: FontStyle.normal,
                  color: Colors.white,
                ),
              ),
              color: merchItem.productAvailability ? Colors.amber : Colors.grey,
              borderRadius: 12.0,
              onPressed: merchItem.productAvailability
                  ? () => buyItem(context)
                  : () {},
            ),
          ],
        ),
      ),
    );
  }

  void buyItem(BuildContext context) async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd/MM/yyyy');
    Transaction transaction = Transaction(
        itemName: merchItem.itemName,
        customer: await SharedPrefs.getStringSharedPreference("mobile"),
        points: merchItem.cost,
        transactionType: "Redemption",
        transactionDate: formatter.format(now));

    SimpleResponse simpleResponse = await bloc.buyMerchItem(transaction);
    navigateToResultPage(context, simpleResponse);
  }

  Future<void> navigateToResultPage(
      BuildContext context, SimpleResponse simpleResponse) async {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MerchPurchaseResponsePage(
              simpleResponse: simpleResponse,
            )));
  }

  Widget _buildCarousel(List<String> images) {
    return CarouselSlider(
      items: images.map<Widget>((i) {
        return Builder(
          builder: (BuildContext context) {
            return ImageItem(
              imageUrl: i,
              fitType: BoxFit.fitHeight,
            );
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
          maxLines: 2,
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
