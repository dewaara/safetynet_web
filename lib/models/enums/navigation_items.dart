import 'package:flutter/material.dart';

enum NavigationItems {
  home,
  users,
  panel,
  pieChart,
}

extension NavigationItemsExtensions on NavigationItems {
  IconData get icon {
    switch (this) {
      case NavigationItems.home:
        return Icons.home;
      case NavigationItems.panel:
        return Icons.message;
      case NavigationItems.pieChart:
        return Icons.contact_page;
      case NavigationItems.users:
        return Icons.call;
      default:
        return Icons.person;
    }
  }
}
