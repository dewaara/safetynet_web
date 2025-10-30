import 'dart:convert';
import 'package:digi_calendar/models/browsing_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://10.244.3.222:8000/api/auth';

  static Future<http.Response> register(
      String name, String email, String password) {
    return http.post(
      Uri.parse('$baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'name': name,
        'email': email,
        'password': password,
      }),
    );
  }

  static Future<http.Response> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response;
  }

  static Future<List<BrowsingData>> fetchBrowsingData(String email) async {
    final response =
        await http.get(Uri.parse("$baseUrl/browsingAdd?email=$email"));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body);
      final List data = jsonData['data'];
      return data.map((item) => BrowsingData.fromJson(item)).toList();
    } else {
      throw Exception("Failed to fetch data: ${response.statusCode}");
    }
  }
}
