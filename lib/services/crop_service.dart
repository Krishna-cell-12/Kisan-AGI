import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisanagi/models/crop_model.dart';

class CropService extends ChangeNotifier {
  static const String _cropsKey = 'crops';
  List<CropModel> _crops = [];

  List<CropModel> get crops => _crops;

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cropsJson = prefs.getString(_cropsKey);
      
      if (cropsJson == null) {
        await _createSampleCrops(prefs);
      } else {
        final List<dynamic> decoded = jsonDecode(cropsJson) as List;
        _crops = decoded.map((c) => CropModel.fromJson(c as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Failed to initialize crop service: $e');
      await _createSampleCrops(await SharedPreferences.getInstance());
    } finally {
      notifyListeners();
    }
  }

  Future<void> _createSampleCrops(SharedPreferences prefs) async {
    _crops = [
      CropModel(
        id: 'crop_1',
        name: 'Rice',
        imageUrl: 'assets/images/Rice_Plant_null_1766472197874.jpg',
        plantedDate: DateTime.now().subtract(const Duration(days: 60)),
        userId: 'user_1',
        status: 'healthy',
        createdAt: DateTime.now().subtract(const Duration(days: 60)),
        updatedAt: DateTime.now(),
      ),
      CropModel(
        id: 'crop_2',
        name: 'Wheat',
        imageUrl: 'assets/images/Wheat_Field_null_1766472199081.jpg',
        plantedDate: DateTime.now().subtract(const Duration(days: 45)),
        userId: 'user_1',
        status: 'healthy',
        createdAt: DateTime.now().subtract(const Duration(days: 45)),
        updatedAt: DateTime.now(),
      ),
      CropModel(
        id: 'crop_3',
        name: 'Cotton',
        imageUrl: 'assets/images/Cotton_Plant_null_1766472200135.jpg',
        plantedDate: DateTime.now().subtract(const Duration(days: 80)),
        userId: 'user_1',
        status: 'diseased',
        createdAt: DateTime.now().subtract(const Duration(days: 80)),
        updatedAt: DateTime.now(),
      ),
      CropModel(
        id: 'crop_4',
        name: 'Sugarcane',
        imageUrl: 'assets/images/Sugarcane_Field_null_1766472201015.jpg',
        plantedDate: DateTime.now().subtract(const Duration(days: 120)),
        userId: 'user_1',
        status: 'healthy',
        createdAt: DateTime.now().subtract(const Duration(days: 120)),
        updatedAt: DateTime.now(),
      ),
      CropModel(
        id: 'crop_5',
        name: 'Tomato',
        imageUrl: 'assets/images/Tomato_Plant_null_1766472201890.jpg',
        plantedDate: DateTime.now().subtract(const Duration(days: 30)),
        userId: 'user_1',
        status: 'healthy',
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
    ];
    await _saveCrops(prefs);
  }

  Future<void> _saveCrops(SharedPreferences prefs) async {
    await prefs.setString(_cropsKey, jsonEncode(_crops.map((c) => c.toJson()).toList()));
  }

  Future<void> addCrop(CropModel crop) async {
    try {
      _crops.add(crop);
      final prefs = await SharedPreferences.getInstance();
      await _saveCrops(prefs);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to add crop: $e');
    }
  }

  Future<void> updateCrop(CropModel crop) async {
    try {
      final index = _crops.indexWhere((c) => c.id == crop.id);
      if (index != -1) {
        _crops[index] = crop;
        final prefs = await SharedPreferences.getInstance();
        await _saveCrops(prefs);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to update crop: $e');
    }
  }

  CropModel? getCropById(String id) => _crops.firstWhere((c) => c.id == id, orElse: () => _crops.first);
}
