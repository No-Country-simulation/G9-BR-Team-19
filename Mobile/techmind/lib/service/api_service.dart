import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:techmind/config/env.dart';

class ApiService {
  Future<List<String>> get(String endpoint) async {
    final response = await http.get(Uri.parse("${Env.apiUrl}$endpoint"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }

    throw Exception("Erro ao buscar dados");
  }

  Future<Map<String, dynamic>> post(
    String endpoint,
    Map<String, dynamic> body,
  ) async {
    final response = await http.post(
      Uri.parse("${Env.apiUrl}$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    }

    throw Exception("Erro ao enviar dados");
  }
}
