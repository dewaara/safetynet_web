import 'package:flutter/material.dart';
import 'package:digi_calendar/models/card_details.dart';
import 'package:digi_calendar/widgets/card_details_widget.dart';
import 'package:digi_calendar/widgets/category_box.dart';

class CardsSection extends StatelessWidget {
  final List<CardDetails> cardDetails;

  const CardsSection({Key? key, required this.cardDetails}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0), // Match DataListPage padding
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white, // Optional background color
          borderRadius: BorderRadius.circular(10),
        ),
        child: CategoryBox(
          title: "Device Control",
          suffix: Container(), // Add icon or action if needed
          children: cardDetails
              .map(
                (CardDetails details) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: CardDetailsWidget(
                    onLock: () {
                      print(
                          'Lock button pressed for card ${details.cardNumber}');
                    },
                    onPause: () {
                      print(
                          'Pause button pressed for card ${details.cardNumber}');
                    },
                    onAddTime: () {
                      print(
                          'Add Time button pressed for card ${details.cardNumber}');
                    },
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
