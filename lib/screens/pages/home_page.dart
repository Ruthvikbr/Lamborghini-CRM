import 'package:flutter/material.dart';
import 'package:lamborghini/screens/components/home_scaffold.dart';
import 'package:lamborghini/screens/components/tab_item.dart';
import 'package:lamborghini/screens/pages/info/categories.dart';
import 'package:lamborghini/screens/pages/merch/merch_page.dart';
import 'package:lamborghini/services/network/api.dart';
import 'package:provider/provider.dart';
import 'account/account_page.dart';
import 'dashboard/dashboard_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTab = TabItem.dashboard;
  int _currentIndex = 0;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.dashboard: GlobalKey<NavigatorState>(),
    TabItem.merch: GlobalKey<NavigatorState>(),
    TabItem.info: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.dashboard: (_) => const DashboardPage(),
      TabItem.merch: (_) => const MerchPage(),
      TabItem.info: (context) => Categories.create(context),
      TabItem.account: (_) => const AccountPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return Provider<ApiBase>(
      create: (context)=> Api(),
      child: WillPopScope(
        onWillPop: () async =>
            !await navigatorKeys[_currentTab]!.currentState!.maybePop(),
        child: HomeScaffold(
          currentTab: _currentTab,
          onSelectTab: _select,
          widgetBuilders: widgetBuilders,
          navigatorKeys: navigatorKeys,
          currentIndex: _currentIndex ,
        ),
      ),
    );
  }

  void _select(int currentIndex) {
    setState(() {
      _currentTab = TabItem.values[currentIndex];
      _currentIndex = currentIndex;
    });
  }
}
