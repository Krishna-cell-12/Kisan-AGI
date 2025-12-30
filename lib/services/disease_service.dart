import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kisanagi/models/disease_model.dart';

class DiseaseService extends ChangeNotifier {
  static const String _diseasesKey = 'diseases';
  List<DiseaseModel> _diseases = [];

  List<DiseaseModel> get diseases => _diseases;
  List<DiseaseModel> get recentScans => _diseases.take(5).toList();

  Future<void> initialize() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final diseasesJson = prefs.getString(_diseasesKey);
      
      if (diseasesJson == null) {
        await _createSampleDiseases(prefs);
      } else {
        final List<dynamic> decoded = jsonDecode(diseasesJson) as List;
        _diseases = decoded.map((d) => DiseaseModel.fromJson(d as Map<String, dynamic>)).toList();
      }
    } catch (e) {
      debugPrint('Failed to initialize disease service: $e');
      await _createSampleDiseases(await SharedPreferences.getInstance());
    } finally {
      notifyListeners();
    }
  }

  Future<void> _createSampleDiseases(SharedPreferences prefs) async {
    _diseases = [
      DiseaseModel(
        id: 'disease_1',
        name: 'Leaf Rust',
        description: 'A fungal disease that causes orange-brown pustules on leaves',
        severity: 'high',
        imageUrl: 'assets/images/Leaf_Rust_Disease_null_1766472202716.jpg',
        cropId: 'crop_2',
        detectedAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      DiseaseModel(
        id: 'disease_2',
        name: 'Bacterial Blight',
        description: 'Causes water-soaked lesions on leaves and stems',
        severity: 'medium',
        imageUrl: 'assets/images/Bacterial_Blight_null_1766472203549.jpg',
        cropId: 'crop_1',
        detectedAt: DateTime.now().subtract(const Duration(days: 5)),
      ),
      DiseaseModel(
        id: 'disease_3',
        name: 'Powdery Mildew',
        description: 'White powdery coating on leaves and stems',
        severity: 'low',
        imageUrl: 'assets/images/Powdery_Mildew_null_1766472204491.jpg',
        cropId: 'crop_3',
        detectedAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
    ];
    await _saveDiseases(prefs);
  }

  Future<void> _saveDiseases(SharedPreferences prefs) async {
    await prefs.setString(_diseasesKey, jsonEncode(_diseases.map((d) => d.toJson()).toList()));
  }

  Future<void> addDisease(DiseaseModel disease) async {
    try {
      _diseases.insert(0, disease);
      final prefs = await SharedPreferences.getInstance();
      await _saveDiseases(prefs);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to add disease: $e');
    }
  }

  DiseaseModel? getDiseaseById(String id) {
    try {
      return _diseases.firstWhere((d) => d.id == id);
    } catch (e) {
      return _diseases.isNotEmpty ? _diseases.first : null;
    }
  }
}
