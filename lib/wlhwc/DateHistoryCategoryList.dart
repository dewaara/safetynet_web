import 'dart:convert';
import 'dart:html' as html; // for image download
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DateHistoryCategoryList extends StatefulWidget {
  final String selectedCategory;
  const DateHistoryCategoryList({Key? key, required this.selectedCategory})
      : super(key: key);

  @override
  State<DateHistoryCategoryList> createState() =>
      _DateHistoryCategoryListState();
}

class _DateHistoryCategoryListState extends State<DateHistoryCategoryList> {
  List<dynamic> _dataList = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchData(widget.selectedCategory);
  }

  @override
  void didUpdateWidget(DateHistoryCategoryList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedCategory != widget.selectedCategory) {
      _fetchData(widget.selectedCategory);
    }
  }

  Future<void> _fetchData(String category) async {
    setState(() => _isLoading = true);

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('jwt_token');

    if (token == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("User not logged in")),
      );
      setState(() => _isLoading = false);
      return;
    }

    final uri = Uri.parse("http://10.244.3.222:8000/pushData");

    try {
      final response = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final allData = (jsonResponse['data'] ?? []) as List;

        final filteredData = category == "All"
            ? allData
            : allData.where((item) => item['category'] == category).toList();

        setState(() => _dataList = filteredData);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error: ${response.statusCode}")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showDetailsDialog(dynamic item) {
    showDialog(
      context: context,
      builder: (context) {
        final imageBase64 = item['imageBase64'];
        final imageBytes = imageBase64 != null
            ? base64Decode(imageBase64.split(',').last)
            : null;

        return Dialog(
          insetPadding: const EdgeInsets.all(20),
          child: Container(
            width: 500,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (imageBytes != null)
                    SizedBox(
                      height: 300,
                      child: InteractiveViewer(
                        panEnabled: true,
                        minScale: 0.5,
                        maxScale: 5,
                        child: Image.memory(imageBytes, fit: BoxFit.contain),
                      ),
                    )
                  else
                    const Icon(Icons.image_not_supported, size: 120),
                  const SizedBox(height: 12),
                  Text(
                    item['name'] ?? 'No Name',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 8),
                  Text(item['complaint'] ?? 'No Description'),
                  const SizedBox(height: 8),
                  Text("📂 Category: ${item['category'] ?? 'N/A'}"),
                  Text("📅 Date: ${item['date'] ?? 'N/A'}"),
                  Text("⏰ Time: ${item['time'] ?? 'N/A'}"),
                  Text("📞 Phone: ${item['phone'] ?? 'N/A'}"),
                  const SizedBox(height: 20),
                  if (imageBytes != null)
                    ElevatedButton.icon(
                      onPressed: () {
                        _downloadImage(imageBase64, item['name'] ?? 'image');
                      },
                      icon: const Icon(Icons.download),
                      label: const Text("Download Image"),
                    ),
                  const SizedBox(height: 10),
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("Close"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _downloadImage(String base64String, String filename) {
    final bytes = base64Decode(base64String.split(',').last);
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute("download", "$filename.jpg")
      ..click();
    html.Url.revokeObjectUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_dataList.isEmpty) {
      return const Center(
        child: Text("No data available for this category."),
      );
    }

    return ListView.builder(
      itemCount: _dataList.length,
      itemBuilder: (context, index) {
        final item = _dataList[index];
        return Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            onTap: () => _showDetailsDialog(item),
            leading: item['imageBase64'] != null
                ? Image.memory(
                    base64Decode(item['imageBase64'].split(',').last),
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                : const Icon(Icons.image_not_supported),
            title: Text(item['name'] ?? 'No Name'),
            subtitle: Text(item['complaint'] ?? 'No Complaint'),
            trailing: Text(item['category'] ?? ''),
          ),
        );
      },
    );
  }
}
