import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisanagi/models/user_model.dart';

class UserService extends ChangeNotifier {
  static const String _userKey = 'current_user';
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString(_userKey);
      
      if (userJson == null) {
        await _createSampleUser(prefs);
      } else {
        _currentUser = UserModel.fromJson(jsonDecode(userJson) as Map<String, dynamic>);
      }
    } catch (e) {
      debugPrint('Failed to initialize user service: $e');
      await _createSampleUser(await SharedPreferences.getInstance());
    } finally {
      notifyListeners();
    }
  }

  Future<void> _createSampleUser(SharedPreferences prefs) async {
    _currentUser = UserModel(
      id: 'user_1',
      name: 'राजेश कुमार',
      phoneNumber: '+91 98765 43210',
      language: 'hi',
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
    await prefs.setString(_userKey, jsonEncode(_currentUser!.toJson()));
  }

  Future<void> updateUser(UserModel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _currentUser = user;
      await prefs.setString(_userKey, jsonEncode(user.toJson()));
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to update user: $e');
    }
  }

  Future<void> setLanguage(String language) async {
    if (_currentUser != null) {
      await updateUser(_currentUser!.copyWith(
        language: language,
        updatedAt: DateTime.now(),
      ));
    }
  }

  Future<void> login(String phoneNumber) async {
    final user = UserModel(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: 'Farmer',
      phoneNumber: phoneNumber,
      language: 'en',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
    await updateUser(user);
  }
}
