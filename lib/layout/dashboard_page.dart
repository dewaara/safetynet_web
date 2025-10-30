import 'package:flutter/material.dart';
import '../models/card_details.dart';
import '../models/enums/card_type.dart';
import '../responsive.dart';
import '../sections/active_map_chart.dart';
import '../sections/device_cards_section.dart';
import '../sections/latest_use_applications.dart';
import '../sections/statics_by_category.dart';
import '../sections/upgrade_pro_section.dart';
import '../styles/styles.dart';
import 'app_layout.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key, required String complaintId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Styles.scaffoldBackgroundColor,
        scrollbarTheme: Styles.scrollbarTheme,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeTab = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: AppLayout(
          content: Row(
            children: [
              // Main Panel
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: Styles.defaultPadding,
                        ),
                        child: const UpgradeProSection(),
                      ),
                    ),
                    const Expanded(
                      flex: 2,
                      child: ActiveMapsCharts(),
                    ),
                    const SizedBox(height: 20.0),
                    Expanded(
                      flex: 2,
                      child: LatestUseApplications(),
                    ),
                  ],
                ),
              ),
              // Right Panel
              Visibility(
                visible: Responsive.isDesktop(context),
                child: Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: Styles.defaultPadding),
                    child: Column(
                      children: [
                        CardsSection(
                          cardDetails: [
                            CardDetails("431421432", CardType.mastercard),
                            // CardDetails("423142231", CardType.mastercard),
                          ],
                        ),
                        const Expanded(
                          child: StaticsByCategory(),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
