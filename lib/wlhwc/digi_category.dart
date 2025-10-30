import 'package:flutter/material.dart';
import 'package:digi_calendar/styles/styles.dart';

class CategorySection extends StatelessWidget {
  final String selectedCategory;
  final Function(String) onCategorySelected;

  const CategorySection({
    Key? key,
    required this.selectedCategory,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color getCardColor(String category) =>
        selectedCategory == category ? Colors.purple.shade100 : Colors.white;
    Color getTextColor(String category) =>
        selectedCategory == category ? Colors.purple : Colors.black;

    Widget buildCategoryCard(String name) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: GestureDetector(
              onTap: () => onCategorySelected(name),
              child: Card(
                color: getCardColor(name),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: Styles.defaultBorderRadius,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Center(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: getTextColor(name),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        buildCategoryCard("All"), // Not a category, shows all records
        buildCategoryCard("Animal"),
        buildCategoryCard("Query"),
        buildCategoryCard("Suggestion"),
        buildCategoryCard("Bard"),
        buildCategoryCard("Other"),
      ],
    );
  }
}
