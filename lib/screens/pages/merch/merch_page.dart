import 'package:flutter/material.dart';
import 'package:lamborghini/blocs/merch_bloc.dart';
import 'package:lamborghini/model/merch_item.dart';
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
            appBar: AppBar(
              title: const Text("Merch"),
            ),
          );
        });
  }
}
