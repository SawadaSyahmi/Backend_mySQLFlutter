import 'package:flutter/material.dart';
import 'package:mysql_backend/services/api_service.dart';

class EditProfileViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  bool _isUpdated = false;

  bool get isUpdated => _isUpdated;

  Future<void> updateProfile(int id, String email, String phone) async {
    _isUpdated = await _apiService.updateProfile(id, email, phone);
    notifyListeners();
  }
}
