import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

class DataListPage extends StatefulWidget {
  @override
  _DataListPageState createState() => _DataListPageState();
}

class _DataListPageState extends State<DataListPage> {
  List<dynamic> _dataList = [];
  bool _isLoading = false;

  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchDataByDate(_formatDate(_selectedDay));
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  Future<void> _fetchDataByDate(String date) async {
    setState(() {
      _isLoading = true;
    });

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("User not logged in")),
      );
      setState(() {
        _isLoading = false;
      });
      return;
    }

    final uri = Uri.parse(
        'http://10.244.3.222:8000/pushData'); // Replace with your endpoint

    try {
      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final allData = jsonResponse['data'] as List;

        // Filter data by selected date
        final filteredData = allData.where((item) {
          return item['date'] == date;
        }).toList();

        setState(() {
          _dataList = filteredData;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Failed to fetch data: ${response.statusCode}")),
        );
      }

//////////////duplicate/////////
      // if (response.statusCode == 200) {
      //   final jsonResponse = jsonDecode(response.body);
      //   final allData = jsonResponse['data'] as List;

      //   // Filter data by selected date AND category "animal"
      //   final filteredData = allData.where((item) {
      //     // Ensure 'category' key exists before checking its value
      //     final isAnimal = item['category'] == 'Query';
      //     final isSelectedDate = item['date'] == date;

      //     return isSelectedDate && isAnimal;
      //   }).toList();

      //   setState(() {
      //     _dataList = filteredData;

      //     // Optional: Check if any data was found for the date and category
      //     if (_dataList.isEmpty) {
      //       ScaffoldMessenger.of(context).showSnackBar(
      //         SnackBar(
      //             content: Text("No animal data found for the selected date.")),
      //       );
      //     }
      //   });
      // } else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //         content: Text("Failed to fetch data: ${response.statusCode}")),
      //   );
      // }

      ///
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            // Custom-styled calendar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: TableCalendar(
                firstDay: DateTime.utc(2020, 1, 1),
                lastDay: DateTime.utc(2030, 12, 31),
                focusedDay: _focusedDay,
                selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                  });
                  final formattedDate = _formatDate(selectedDay);
                  _fetchDataByDate(formattedDate);
                },
                calendarStyle: const CalendarStyle(
                  selectedDecoration: BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  todayDecoration: BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                ),
                headerStyle: const HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  titleTextStyle: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator()
                : Expanded(
                    child: _dataList.isNotEmpty
                        ? ListView.builder(
                            itemCount: _dataList.length,
                            itemBuilder: (context, index) {
                              final item = _dataList[index];
                              return Card(
                                elevation: 2,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                child: ListTile(
                                  leading: item['imageBase64'] != null
                                      ? Image.memory(
                                          base64Decode(item['imageBase64']
                                              .split(',')[1]),
                                          width: 50,
                                          height: 50,
                                          fit: BoxFit.cover,
                                        )
                                      : Icon(Icons.image_not_supported),
                                  title: Text(item['name'] ?? 'No Name'),
                                  subtitle:
                                      Text(item['complaint'] ?? 'No Complaint'),
                                  trailing: Text(item['date'] ?? ''),
                                ),
                              );
                            },
                          )
                        : Center(
                            child: Text(
                                "No data available for the selected date."),
                          ),
                  ),
          ],
        ),
      ),
    );
  }
}
