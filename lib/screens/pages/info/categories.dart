import 'package:flutter/material.dart';
import 'package:lamborghini/blocs/categories_bloc.dart';
import 'package:lamborghini/model/list_item_builder.dart';
import 'package:lamborghini/model/parent.dart';
import 'package:lamborghini/screens/components/category_item.dart';
import 'package:lamborghini/services/network/api.dart';
import 'package:provider/provider.dart';

import 'car_list_page.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key, required this.bloc}) : super(key: key);
  final CategoriesBloc bloc;

  static Widget create(BuildContext context) {
    final apiBase = Provider.of<ApiBase>(context, listen: false);
    return Provider<CategoriesBloc>(
      create: (_) => CategoriesBloc(apiBase: apiBase),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<CategoriesBloc>(
        builder: (_, bloc, __) => Categories(bloc: bloc),
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
              onPress: () => navigateToCarDetailsScreen(
                context,
                parent,
              ),
            ),
          ),
        );
      },
    );
  }

  void navigateToCarDetailsScreen(BuildContext context, Parent parent) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CarList(bloc: bloc, parent: parent),
      ),
    );
  }
}
