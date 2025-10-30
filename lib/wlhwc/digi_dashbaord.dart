import 'package:digi_calendar/layout/app_layout.dart';
import 'package:digi_calendar/models/card_details.dart';
import 'package:digi_calendar/models/enums/card_type.dart';
import 'package:digi_calendar/responsive.dart';
import 'package:digi_calendar/sections/device_cards_section.dart';
import 'package:digi_calendar/wlhwc/DateHistoryCategoryList.dart';
import 'package:digi_calendar/wlhwc/date_list_data.dart';
import 'package:digi_calendar/wlhwc/digi_category.dart';
import 'package:digi_calendar/wlhwc/digi_salider_banner.dart';
import 'package:flutter/material.dart';
import '../styles/styles.dart';

class DigiDashboard extends StatelessWidget {
  const DigiDashboard({super.key});

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
  String _selectedCategory = "All";

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
                    SizedBox(
                      height: 150,
                      child: CarouselBanners(),
                    ),
                    const SizedBox(height: 15.0),
                    SizedBox(
                      height: 120,
                      child: CategorySection(
                        selectedCategory: _selectedCategory,
                        onCategorySelected: (category) {
                          setState(() {
                            _selectedCategory = category;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 15.0),
                    Flexible(
                      child: DateHistoryCategoryList(
                        selectedCategory: _selectedCategory,
                      ),
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
                          ],
                        ),
                        Expanded(
                          child: DataListPage(),
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
