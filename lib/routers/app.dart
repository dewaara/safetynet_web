import 'package:digi_calendar/layout/dashboard_page.dart';
import 'package:digi_calendar/wlhwc/auth_pages.dart';
import 'package:digi_calendar/wlhwc/digi_dashbaord.dart';
import 'package:digi_calendar/wlhwc/login_page_home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../sections/active_map_chart.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin Panel',
      themeMode: ThemeMode.system,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/second-screen',
          page: () => ActiveMapsCharts(),
        ),
        GetPage(
          name: '/digi-dashboard',
          page: () => const DigiDashboard(),
        ),
      ],
    );
  }
}
