import 'package:digi_calendar/models/usages.dart';
import 'package:flutter/material.dart';

class UsagesWidget extends StatelessWidget {
  final Usages usages;

  const UsagesWidget({Key? key, required this.usages}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 18),
      child: Row(
        children: [
          Container(
            height: 10,
            width: 10,
            margin: const EdgeInsets.only(right: 18),
            decoration: BoxDecoration(
              color: usages.color,
              shape: BoxShape.circle,
            ),
          ),
          Expanded(
            child: Text(
              "${usages.expenseName} - ${usages.expensePercentage.round()}%",
              style: const TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
