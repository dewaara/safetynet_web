import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import '../models/CardData.dart';

class ComplaintService {
  static Future<List<CardData>> fetchComplaintsData() async {
    final url = Uri.parse('http://10.244.3.222:8000/pushData');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List data = jsonResponse['data'];

      return data.map<CardData>((e) {
        String imageUrl = '';
        try {
          if (e['imageBase64'] != null && e['imageBase64'].contains(',')) {
            final base64Str = e['imageBase64'].split(',').last;
            imageUrl = 'data:image/png;base64,$base64Str';
          }
        } catch (_) {}

        return CardData(
          imageUrl: imageUrl,
          title: e['name'] ?? 'No Name',
          description:
              "Phone: ${e['phone'] ?? 'N/A'}\nComplaint: ${e['complaint'] ?? 'N/A'}",
        );
      }).toList();
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}
