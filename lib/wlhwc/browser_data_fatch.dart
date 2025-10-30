import 'package:digi_calendar/apis/api_service.dart';
import 'package:digi_calendar/models/browsing_model.dart';
import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class BrowsingDataPage extends StatefulWidget {
  const BrowsingDataPage({super.key});

  @override
  State<BrowsingDataPage> createState() => _BrowsingDataPageState();
}

class _BrowsingDataPageState extends State<BrowsingDataPage> {
  final TextEditingController _emailController = TextEditingController();
  List<BrowsingData> browsingList = [];
  bool isLoading = false;
  String? errorMessage;

  Future<void> fetchData() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      setState(() => errorMessage = "Please enter an email address");
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = null;
    });

    try {
      final data = await ApiService.fetchBrowsingData(email);
      setState(() {
        browsingList = data;
      });
    } catch (e) {
      setState(() => errorMessage = e.toString());
    } finally {
      setState(() => isLoading = false);
    }
  }

  String formatTimestamp(int timestamp) {
    try {
      final date = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return DateFormat('yyyy-MM-dd HH:mm:ss').format(date);
    } catch (e) {
      return "Invalid Timestamp";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Browsing Data Viewer")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: "Enter Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton(
                  onPressed: isLoading ? null : fetchData,
                  child: const Text("Fetch Data"),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isLoading)
              const CircularProgressIndicator()
            else if (errorMessage != null)
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red),
              )
            else if (browsingList.isEmpty)
              const Text("No data found")
            else
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: DataTable(
                    border: TableBorder.all(color: Colors.grey),
                    columns: const [
                      DataColumn(label: Text("Email")),
                      DataColumn(label: Text("Android ID")),
                      DataColumn(label: Text("URL")),
                      DataColumn(label: Text("Timestamp")),
                    ],
                    rows: browsingList.map((item) {
                      return DataRow(cells: [
                        DataCell(Text(item.email)),
                        DataCell(Text(item.androidId)),
                        DataCell(Text(item.urls)),
                        DataCell(Text(formatTimestamp(item.timestamp))),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
