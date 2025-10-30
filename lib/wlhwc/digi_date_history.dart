import 'dart:convert';
import 'package:digi_calendar/apis/complaint_service.dart';
import 'package:digi_calendar/data/mock_data.dart';
import 'package:digi_calendar/models/CardData.dart';
import 'package:digi_calendar/models/usages.dart';
import 'package:digi_calendar/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class DateHistory extends StatefulWidget {
  const DateHistory({Key? key}) : super(key: key);

  @override
  State<DateHistory> createState() => _DateHistoryState();
}

class _DateHistoryState extends State<DateHistory> {
  int touchedIndex = -1;
  final ScrollController _scrollController = ScrollController();

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  bool _isLoading = false;
  List<CardData> _cardDataList = [];

  @override
  void initState() {
    super.initState();
    loadComplaints(); // ⬅️ changed
  }

  Future<void> loadComplaints() async {
    setState(() => _isLoading = true);
    try {
      final data = await ComplaintService.fetchComplaintsData();
      setState(() {
        _cardDataList = data;
      });
    } catch (e) {
      showError("Error: $e");
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Styles.defaultPadding),
      child: Column(
        children: [
          Expanded(child: _scrollableCardView(_cardDataList)),
        ],
      ),
    );
  }

  Widget _scrollableCardView(List<CardData> data) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (data.isEmpty) {
      return const Center(child: Text("No data available"));
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      scrollDirection: Axis.vertical,
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          shadowColor: Colors.grey.withOpacity(0.5),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    data[index].imageUrl,
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.broken_image,
                        size: 50,
                        color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    data[index].description,
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
