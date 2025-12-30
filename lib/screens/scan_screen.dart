import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'package:kisanagi/theme.dart';
import 'package:kisanagi/config.dart';
import 'package:kisanagi/services/disease_service.dart';
import 'package:kisanagi/models/disease_model.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({super.key});

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _flashOn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Container(
                margin: AppSpacing.paddingLg,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: LightModeColors.lightSecondary,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(21),
                  child: AspectRatio(
                    aspectRatio: 3 / 4,
                    child: Container(
                      color: Colors.grey[900],
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera_alt,
                              size: 80,
                              color: Colors.white.withValues(alpha: 0.5),
                            ),
                            const SizedBox(height: AppSpacing.lg),
                            Text(
                              'Camera Preview',
                              style: context.textStyles.titleLarge?.copyWith(
                                color: Colors.white.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: AppSpacing.md,
              left: AppSpacing.md,
              child: IconButton(
                icon: const Icon(Icons.close, color: Colors.white, size: 28),
                onPressed: () => context.pop(),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: AppSpacing.paddingLg,
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                      vertical: AppSpacing.md,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.7),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '📸 Point camera at the affected leaf',
                      style: context.textStyles.titleMedium?.copyWith(
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: AppSpacing.xl,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ActionButton(
                    icon: Icons.photo_library,
                    label: 'Gallery',
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  _CaptureButton(
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                  _ActionButton(
                    icon: _flashOn ? Icons.flash_on : Icons.flash_off,
                    label: _flashOn ? 'Flash On' : 'Flash',
                    onTap: () {
                      setState(() => _flashOn = !_flashOn);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(_flashOn ? 'Flash enabled for in-app camera (not implemented)' : 'Flash disabled')),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    // Request runtime permission before picking
    bool granted = await _requestPermissionFor(source);
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Permission denied')));
      return;
    }

    final XFile? image = await _picker.pickImage(source: source);
    if (image == null || !mounted) return;

    // Show loading dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    try {
      final bytes = await image.readAsBytes();

      final uri = Uri.parse('${Config.baseUrl}/api/diagnose');
      final request = http.MultipartRequest('POST', uri);
      request.files.add(http.MultipartFile.fromBytes('leaf_image', bytes, filename: image.name));

      final streamed = await request.send();
      final response = await http.Response.fromStream(streamed);

      Navigator.of(context).pop(); // close loading

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;

        final int confidence = (data['confidence_score'] ?? 0).round();
        final String severity = confidence >= 80 ? 'high' : (confidence >= 50 ? 'medium' : 'low');

        final String diseaseName = data['disease_name'] ?? 'Unknown';
        final String description = (data['timeline'] != null && data['timeline'] is List && data['timeline'].isNotEmpty)
            ? (data['timeline'][0]['detail'] ?? '')
            : '';

        final disease = DiseaseModel(
          id: UniqueKey().toString(),
          name: diseaseName,
          description: description,
          severity: severity,
          imageUrl: image.path,
          cropId: 'crop_1',
          detectedAt: DateTime.now(),
        );

        // Save to local service
        context.read<DiseaseService>().addDisease(disease);

        // Navigate to new diagnosis screen
        context.push('/diagnosis/${disease.id}');
      } else {
        final msg = response.body.isNotEmpty ? response.body : 'Server error ${response.statusCode}';
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Diagnosis failed: $msg')));
      }
    } catch (e) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<bool> _requestPermissionFor(ImageSource source) async {
    try {
      if (source == ImageSource.camera) {
        final status = await Permission.camera.request();
        return status.isGranted;
      } else {
        // gallery
        if (Platform.isAndroid) {
          // Android 13+ uses READ_MEDIA_IMAGES
          final status = await Permission.photos.request();
          if (status.isGranted) return true;
          final st2 = await Permission.storage.request();
          return st2.isGranted;
        } else {
          final status = await Permission.photos.request();
          return status.isGranted;
        }
      }
    } catch (e) {
      return false;
    }
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: context.textStyles.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _CaptureButton extends StatelessWidget {
  final VoidCallback onTap;

  const _CaptureButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: const BoxDecoration(
            color: LightModeColors.lightSecondary,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}
