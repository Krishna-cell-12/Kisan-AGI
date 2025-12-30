import 'package:flutter/material.dart';
import 'package:kisanagi/models/recovery_plan_model.dart';

class RecoveryPlanService {
  RecoveryPlanModel getRecoveryPlanForDisease(String diseaseId, String diseaseName) {
    switch (diseaseName.toLowerCase()) {
      case 'leaf rust':
        return RecoveryPlanModel(
          id: 'plan_1',
          diseaseId: diseaseId,
          steps: [
            RecoveryStep(
              title: 'Immediate Action',
              description: 'Remove and destroy all infected leaves immediately. Isolate affected plants to prevent spread to healthy crops.',
              accentColor: const Color(0xFFE53935),
            ),
            RecoveryStep(
              title: 'Treatment',
              description: 'Apply fungicide containing propiconazole or tebuconazole. Spray every 7-10 days for 3 weeks.',
              accentColor: const Color(0xFF1E88E5),
              actionButton: 'Buy Fungicide',
            ),
            RecoveryStep(
              title: 'Prevention',
              description: 'Plant resistant varieties, ensure proper spacing for air circulation, avoid overhead watering.',
              accentColor: const Color(0xFF43A047),
            ),
          ],
        );
      case 'bacterial blight':
        return RecoveryPlanModel(
          id: 'plan_2',
          diseaseId: diseaseId,
          steps: [
            RecoveryStep(
              title: 'Immediate Action',
              description: 'Remove infected plant parts and burn them. Avoid working with plants when wet to prevent spread.',
              accentColor: const Color(0xFFE53935),
            ),
            RecoveryStep(
              title: 'Treatment',
              description: 'Apply copper-based bactericide (e.g., Bordeaux mixture). Treat every 5-7 days until symptoms disappear.',
              accentColor: const Color(0xFF1E88E5),
              actionButton: 'Buy Bactericide',
            ),
            RecoveryStep(
              title: 'Prevention',
              description: 'Use disease-free seeds, practice crop rotation, maintain field sanitation, avoid excess nitrogen fertilizer.',
              accentColor: const Color(0xFF43A047),
            ),
          ],
        );
      case 'powdery mildew':
        return RecoveryPlanModel(
          id: 'plan_3',
          diseaseId: diseaseId,
          steps: [
            RecoveryStep(
              title: 'Immediate Action',
              description: 'Prune infected leaves and improve air circulation around plants. Remove plant debris from the field.',
              accentColor: const Color(0xFFE53935),
            ),
            RecoveryStep(
              title: 'Treatment',
              description: 'Spray with sulfur-based fungicide or neem oil. Apply weekly until infection clears.',
              accentColor: const Color(0xFF1E88E5),
              actionButton: 'Buy Treatment',
            ),
            RecoveryStep(
              title: 'Prevention',
              description: 'Ensure adequate plant spacing, avoid overhead watering, apply preventive fungicide during humid weather.',
              accentColor: const Color(0xFF43A047),
            ),
          ],
        );
      default:
        return RecoveryPlanModel(
          id: 'plan_default',
          diseaseId: diseaseId,
          steps: [
            RecoveryStep(
              title: 'Immediate Action',
              description: 'Isolate affected plants and remove visibly diseased parts.',
              accentColor: const Color(0xFFE53935),
            ),
            RecoveryStep(
              title: 'Treatment',
              description: 'Consult with local agricultural extension office for specific treatment recommendations.',
              accentColor: const Color(0xFF1E88E5),
              actionButton: 'Find Help',
            ),
            RecoveryStep(
              title: 'Prevention',
              description: 'Practice good field hygiene, use resistant varieties, and monitor crops regularly.',
              accentColor: const Color(0xFF43A047),
            ),
          ],
        );
    }
  }
}
