import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:ticketly/shared/constants.dart';
import '../models/ticket_model.dart';

class TicketApiService {
  static const String baseUrl = kTicketsBaseUrl;

  static Future<List<TicketModel>> fetchTickets() async {
    final url = Uri.parse('$baseUrl/posts');

    try {
      final response = await http.get(url);

      log(
        'Fetching tickets from API: $url, Status Code: ${response.statusCode}',
      );
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
