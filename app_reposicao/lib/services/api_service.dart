import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<bool> registerUser(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response.statusCode == 201;
  }

  static Future<bool> loginUser(String email, String password) async {
    final response = await http.get(Uri.parse('$baseUrl/users?email=$email&password=$password'));
    final data = jsonDecode(response.body);
    return data.isNotEmpty;
  }

  static Future<bool> addProduct(String name, String description) async {
    final response = await http.post(
      Uri.parse('$baseUrl/products'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'name': name, 'description': description}),
    );
    return response.statusCode == 201;
  }

  static Future<List<Map<String, dynamic>>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));
    return List<Map<String, dynamic>>.from(jsonDecode(response.body));
  }
}
