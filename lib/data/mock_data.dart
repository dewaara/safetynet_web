import 'package:digi_calendar/models/ExpenseData.dart';
import 'package:digi_calendar/models/enums/application_type.dart';
import 'package:digi_calendar/models/usages.dart';
import 'package:digi_calendar/models/application.dart';
import 'package:digi_calendar/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MockData {
  static BarChartGroupData makeGroupData(
      int x, double y1, Color barColor, double width) {
    return BarChartGroupData(
      barsSpace: 1,
      x: x,
      barRods: [
        BarChartRodData(
          toY: y1,
          color: barColor,
          width: width,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
      ],
    );
  }

  static List<BarChartGroupData> getBarChartitems(Color color,
      {double width = 20}) {
    return [
      makeGroupData(0, 5, color, width),
      makeGroupData(1, 6, color, width),
      makeGroupData(2, 8, color, width),
      makeGroupData(3, 5, color, width),
      makeGroupData(4, 7, color, width),
      makeGroupData(5, 9, color, width),
      makeGroupData(6, 3, color, width),
    ];
  }

  static List<Application> get transactions {
    return [
      Application(
        "com.facebook.app",
        "Facebook",
        DateTime.now(),
        ApplicationType.incoming,
        "https://upload.wikimedia.org/wikipedia/en/thumb/0/04/Facebook_f_logo_%282021%29.svg/512px-Facebook_f_logo_%282021%29.svg.png?20210818083032",
      ),
      Application(
        "com.amazon.india",
        "Amazon",
        DateTime.now(),
        ApplicationType.incoming,
        "https://cdn0.iconfinder.com/data/icons/most-usable-logos/120/Amazon-512.png",
      ),
      Application(
        "uk.instagram.meta",
        "Instagram",
        DateTime.now(),
        ApplicationType.incoming,
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHP2W0X8Bj9Wwou8Y5Iv2q_Aa-nME9SMwEAA&s",
      ),
    ];
  }

  static List<Usages> get otherExpanses {
    return [
      Usages(
        color: Styles.defaultBlueColor,
        expenseName: "Other Apps",
        expensePercentage: 50,
      ),
      Usages(
        color: Styles.defaultRedColor,
        expenseName: "Entertainment",
        expensePercentage: 35,
      ),
      Usages(
        color: Styles.defaultYellowColor,
        expenseName: "Social Media",
        expensePercentage: 15,
      )
    ];
  }

  static List<ExpenseData> cardExpanses = [
    ExpenseData(
      name: "Food",
      expensePercentage: 25.0,
      color: Colors.blue,
      imageUrl: "https://via.placeholder.com/150", // Replace with actual URL
      description: "Monthly food and groceries",
    ),
    ExpenseData(
      name: "Entertainment",
      expensePercentage: 15.0,
      color: Colors.red,
      imageUrl: "https://via.placeholder.com/150",
      description:
          "Movies, subscriptions, and fun activitiesMovies, subscriptions, and fun activities",
    ),
    ExpenseData(
      name: "Transport",
      expensePercentage: 10.0,
      color: Colors.green,
      imageUrl: "https://via.placeholder.com/150",
      description: "Daily commute and fuel expenses",
    ),
    ExpenseData(
      name: "Transport",
      expensePercentage: 10.0,
      color: Colors.green,
      imageUrl: "https://via.placeholder.com/150",
      description: "Daily commute and fuel expenses",
    ),
    ExpenseData(
      name: "Transport",
      expensePercentage: 10.0,
      color: Colors.green,
      imageUrl: "https://via.placeholder.com/150",
      description: "Daily commute and fuel expenses",
    ),
    ExpenseData(
      name: "Transport",
      expensePercentage: 10.0,
      color: Colors.green,
      imageUrl: "https://via.placeholder.com/150",
      description: "Daily commute and fuel expenses",
    ),
  ];
}
