import 'package:flutter/material.dart';

enum TabItem { dashboard, merch, info, account }

class TabItemData{
  const TabItemData({required this.title, required this.icon});
  final String title;
  final IconData icon;

  static const Map<TabItem, TabItemData> allTabs = {
    TabItem.dashboard: TabItemData(title: "Dashboard", icon: Icons.dashboard),
    TabItem.merch: TabItemData(title: "Merch", icon: Icons.store),
    TabItem.info: TabItemData(title: "Categories", icon: Icons.electric_car),
    TabItem.account: TabItemData(title: "Account", icon: Icons.person),
  };

}