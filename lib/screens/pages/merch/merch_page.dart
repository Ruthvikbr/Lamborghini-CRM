import 'package:flutter/material.dart';
import 'package:lamborghini/blocs/merch_bloc.dart';
import 'package:lamborghini/screens/components/list_item_builder.dart';
import 'package:lamborghini/model/merch_item.dart';
import 'package:lamborghini/screens/components/merch_item.dart';
import 'package:lamborghini/screens/pages/merch/merch_item_detail_page.dart';
import 'package:lamborghini/services/network/api.dart';
import 'package:provider/provider.dart';

class MerchPage extends StatelessWidget {
  const MerchPage({Key? key, required this.merchBloc}) : super(key: key);
  final MerchBloc merchBloc;

  static Widget create(BuildContext context) {
    final apiBase = Provider.of<ApiBase>(context, listen: false);
    return Provider<MerchBloc>(
      create: (_) => MerchBloc(apiBase: apiBase),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<MerchBloc>(
        builder: (_, bloc, __) => MerchPage(merchBloc: bloc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MerchItem>>(
        stream: merchBloc.merchStream,
        builder: (context, snapshot) {
          return Scaffold(
              backgroundColor: Colors.black,
              body: ListItemBuilder<MerchItem>(
                snapshot: snapshot,
                itemWidgetBuilder: (context, item) => MerchListItem(
                  item: item,
                  onPress: (item) => {},
                ),
                onPress: (item) => navigateToDetailsScreen(context, item),
              ));
        });
  }

  void navigateToDetailsScreen(BuildContext context, MerchItem merchItem) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MerchItemDetailPage(
              merchItem: merchItem,
              bloc: merchBloc,
            )));
  }
}
