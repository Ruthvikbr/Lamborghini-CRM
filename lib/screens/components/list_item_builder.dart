import 'package:flutter/material.dart';
import 'package:lamborghini/model/merch_item.dart';
import 'package:lamborghini/screens/components/something_went_wrong.dart';
import 'package:lamborghini/screens/components/text_component.dart';

typedef ItemWidgetBuilder<T> = Widget Function(BuildContext context, T item);

class ListItemBuilder<T> extends StatelessWidget {
  const ListItemBuilder({
    Key? key,
    required this.snapshot,
    required this.itemWidgetBuilder,
    this.onPress,
  }) : super(key: key);

  final ItemWidgetBuilder<T> itemWidgetBuilder;
  final AsyncSnapshot<List<T>> snapshot;
  final Function(T)? onPress;

  @override
  Widget build(BuildContext context) {
    if (snapshot.hasData && snapshot.data != null) {
      final List<T> items = snapshot.data!;
      if (items.isNotEmpty) {
        debugPrint("${items is List<MerchItem>}");
        if (items is List<MerchItem>) {
          return _gridList(items as List<MerchItem>, context);
        } else {
          return _buildList(items);
        }
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

  Widget _gridList(List<MerchItem> items, BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 5,
        crossAxisSpacing: 5,
        childAspectRatio: 0.7,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
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
                    child: Image.network(items[index].primaryDisplayImage)),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 4.0),
                  child: TextComponent(
                    text: items[index].itemName.toString(),
                    textStyle: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 4.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextComponent(
                        text: "${items[index].cost.toString()} PTS",
                        textStyle:
                            const TextStyle(color: Colors.red, fontSize: 16),
                        textAlign: TextAlign.left,
                        maxLines: 1,
                      ),
                      TextComponent(
                        text: items[index].discount != null && items[index].discount!= 0.0
                            ? "${items[index].discount.toString()} PTS"
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
          onTap: () => onPress!(items[index] as T),
        );
      },
    );
  }
}
