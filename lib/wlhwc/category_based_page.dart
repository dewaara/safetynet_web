import 'package:digi_calendar/wlhwc/DateHistoryCategoryList.dart';
import 'package:digi_calendar/wlhwc/digi_category.dart';
import 'package:flutter/material.dart';

class CategoryBasedPage extends StatefulWidget {
  const CategoryBasedPage({Key? key}) : super(key: key);

  @override
  State<CategoryBasedPage> createState() => _CategoryBasedPageState();
}

class _CategoryBasedPageState extends State<CategoryBasedPage> {
  String _selectedCategory = "All"; // default: show everything

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Category History")),
      body: Column(
        children: [
          const SizedBox(height: 10),
          CategorySection(
            selectedCategory: _selectedCategory,
            onCategorySelected: (category) {
              setState(() => _selectedCategory = category);
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: DateHistoryCategoryList(
              selectedCategory: _selectedCategory,
            ),
          ),
        ],
      ),
    );
  }
}
