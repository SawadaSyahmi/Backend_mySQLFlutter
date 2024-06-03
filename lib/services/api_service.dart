// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mysql_backend/models/user.dart';

class ApiService {
  static const String baseUrl = 'http://127.0.0.1:3306 ';

  Future<User?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{'username': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<User?> getProfile(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/profile/$id'));

    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }

  Future<bool> updateProfile(int id, String email, String phone) async {
    final response = await http.put(
      Uri.parse('$baseUrl/profile/$id'),
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(<String, String>{'email': email, 'phone': phone}),
    );

    return response.statusCode == 200;
  }
}
