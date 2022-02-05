import 'package:flutter/material.dart';
import 'package:lamborghini/blocs/info_bloc.dart';
import 'package:lamborghini/model/list_item_builder.dart';
import 'package:lamborghini/model/parent.dart';
import 'package:lamborghini/screens/components/category_item.dart';
import 'package:lamborghini/services/network/api.dart';
import 'package:provider/provider.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key, required this.bloc}) : super(key: key);
  final InfoBloc bloc;

  static Widget create(BuildContext context) {
    final apiBase = Provider.of<ApiBase>(context, listen: false);
    return Provider<InfoBloc>(
      create: (_) => InfoBloc(apiBase: apiBase),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<InfoBloc>(
        builder: (_, bloc, __) => InfoPage(bloc: bloc),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Parent>>(
      stream: bloc.parentStream,
      builder: (context, snapshot) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: ListItemBuilder<Parent>(
            snapshot: snapshot,
            itemWidgetBuilder: (context, parent) => CategoryItem(
              parent: parent,
            ),
          ),
        );
      },
    );
  }
}
