import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/ticket_model.dart';

class TicketApiService {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';
  
  static Future<List<TicketModel>> fetchTickets() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/posts'));
      
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        return jsonData.map((json) => TicketModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch tickets: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }
}