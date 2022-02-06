import 'package:flutter/material.dart';
import 'package:lamborghini/screens/components/something_went_wrong.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key? key,
    required this.snapshot,
    required this.itemWidgetBuilder,
  }) : super(key: key);

  final ItemWidgetBuilder<T> itemWidgetBuilder;
  final AsyncSnapshot<List<T>> snapshot;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData && snapshot.data != null) {
      final List<T> items = snapshot.data!;
      if (items.isNotEmpty) {
       return _buildList(items);
      } else {
        return const SomethingWentWrongPage();
      }
    } else if (snapshot.hasError) {
      return const SomethingWentWrongPage();
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }
  }

  Widget _buildList(List<T> items) {
    return ListView.builder(
        itemCount: items.length + 2,
        itemBuilder: (context, index) {
          if (index == 0 || index == items.length + 1) {
            return Container();
          }
          return itemWidgetBuilder(context, items[index - 1]);
        });
  }
}
