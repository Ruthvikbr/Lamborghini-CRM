import 'package:flutter/material.dart';
import 'package:lamborghini/model/simple_response.dart';
import 'package:lamborghini/screens/components/text_component.dart';

class MerchPurchaseResponsePage extends StatelessWidget {
  const MerchPurchaseResponsePage({Key? key, required this.simpleResponse})
      : super(key: key);
  final SimpleResponse simpleResponse;

  @override
  Widget build(BuildContext context) {
    debugPrint(simpleResponse.message);
    return Scaffold(
      appBar: AppBar(
        title: const Text("PURCHASE STATUS"),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            simpleResponse.isSuccessful? "assets/images/check.png" : "assets/images/remove.png" ,
            width: 200,
            height: 100,
          ),
          const SizedBox(height: 20,),
          TextComponent(
            text: simpleResponse.isSuccessful? "SUCCESSFUL" : "PURCHASE FAILED",
            textStyle: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10,),
          TextComponent(
            text: !simpleResponse.isSuccessful? simpleResponse.message : "",
            textStyle: const TextStyle(
              color: Colors.deepOrange,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
            maxLines: 3,
            textAlign: TextAlign.center,
          )

        ],
      ),
    );
  }
}
