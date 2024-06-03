import 'package:flutter/material.dart';
import 'package:mysql_backend/models/user.dart';
import 'package:mysql_backend/services/api_service.dart';

class ProfileViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  User? _user;

  User? get user => _user;

  Future<void> fetchProfile(int id) async {
    _user = await _apiService.getProfile(id);
    notifyListeners();
  }
}
