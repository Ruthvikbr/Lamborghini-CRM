import 'package:flutter/material.dart';
import 'package:lamborghini/screens/components/tab_item.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold(
      {Key? key,
      required this.currentTab,
      required this.onSelectTab,
      required this.widgetBuilders,
      required this.navigatorKeys,
      required this.currentIndex
      })
      : super(key: key);

  final TabItem currentTab;
  final int currentIndex;
  final ValueChanged<int> onSelectTab;
  final Map<TabItem, WidgetBuilder> widgetBuilders;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: widgetBuilders.values.elementAt(currentIndex).call(context),
      ),
      bottomNavigationBar: BottomNavigationBar(

        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          _buildItem(TabItem.dashboard),
          _buildItem(TabItem.merch),
          _buildItem(TabItem.info),
          _buildItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab(
          index,
        ),
        currentIndex: currentIndex,
        backgroundColor: Colors.black,
        unselectedFontSize: 10.0,
        selectedFontSize: 10.0,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    final TabItemData itemData = TabItemData.allTabs[tabItem]!;

    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
      ),
      label: itemData.title,
      backgroundColor: Colors.black,
    );
  }
}
