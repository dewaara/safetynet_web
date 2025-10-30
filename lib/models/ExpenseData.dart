import 'package:flutter/material.dart';

class ExpenseData {
  final String name;
  final double expensePercentage;
  final Color color;
  final String imageUrl;
  final String description;

  ExpenseData({
    required this.name,
    required this.expensePercentage,
    required this.color,
    required this.imageUrl,
    required this.description,
  });
}
