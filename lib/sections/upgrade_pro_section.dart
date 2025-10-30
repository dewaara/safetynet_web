import 'package:flutter/material.dart';
import 'package:digi_calendar/responsive.dart';
import 'package:digi_calendar/styles/styles.dart';

class UpgradeProSection extends StatelessWidget {
  const UpgradeProSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.spaceEvenly, // Even space distribution
      children: [
        // First Card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: Styles.defaultBorderRadius,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Card 1",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Second Card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: Styles.defaultBorderRadius,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Card 2",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Third Card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: Styles.defaultBorderRadius,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Card 3",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Fourth Card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: Styles.defaultBorderRadius,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Card 4",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Fifth Card
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: Styles.defaultBorderRadius,
              ),
              child: const Padding(
                padding: EdgeInsets.all(10),
                child: Center(
                  child: Text(
                    "Card 5",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
