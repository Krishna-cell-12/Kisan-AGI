import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:kisanagi/models/recovery_plan_model.dart';
import 'package:kisanagi/services/crop_service.dart';
import 'package:kisanagi/services/disease_service.dart';
import 'package:kisanagi/services/recovery_plan_service.dart';
import 'package:kisanagi/theme.dart';

class DiagnosisScreen extends StatelessWidget {
  final String diseaseId;

  const DiagnosisScreen({super.key, required this.diseaseId});

  @override
  Widget build(BuildContext context) {
    final disease = context.read<DiseaseService>().getDiseaseById(diseaseId);
    
    if (disease == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Disease Not Found'),
        ),
        body: const Center(
          child: Text('Unable to load disease information'),
        ),
      );
    }

    final crop = context.read<CropService>().getCropById(disease.cropId);
    final recoveryPlan = RecoveryPlanService().getRecoveryPlanForDisease(
      disease.id,
      disease.name,
    );

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
              onPressed: () => context.pop(),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.asset(
                disease.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.bug_report,
                    size: 80,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: AppSpacing.paddingLg,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.sm,
                        ),
                        decoration: BoxDecoration(
                          color: _getSeverityColor(disease.severity).withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '${disease.severity.toUpperCase()} SEVERITY',
                          style: context.textStyles.labelMedium?.copyWith(
                            color: _getSeverityColor(disease.severity),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Spacer(),
                      Icon(
                        Icons.eco,
                        size: 20,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        crop?.name ?? 'Unknown Crop',
                        style: context.textStyles.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    disease.name,
                    style: context.textStyles.headlineLarge,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    disease.description,
                    style: context.textStyles.bodyLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Row(
                    children: [
                      Text(
                        'Recovery Timeline',
                        style: context.textStyles.headlineSmall,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      const Icon(Icons.healing, size: 24),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => Padding(
                padding: EdgeInsets.only(
                  left: AppSpacing.lg,
                  right: AppSpacing.lg,
                  bottom: index == recoveryPlan.steps.length - 1 ? AppSpacing.xl : 0,
                ),
                child: RecoveryStepCard(
                  step: recoveryPlan.steps[index],
                  stepNumber: index + 1,
                  isLast: index == recoveryPlan.steps.length - 1,
                ),
              ),
              childCount: recoveryPlan.steps.length,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'high':
        return LightModeColors.accentRed;
      case 'medium':
        return LightModeColors.lightSecondary;
      case 'low':
        return LightModeColors.accentGreen;
      default:
        return LightModeColors.lightPrimary;
    }
  }
}

class RecoveryStepCard extends StatelessWidget {
  final RecoveryStep step;
  final int stepNumber;
  final bool isLast;

  const RecoveryStepCard({
    super.key,
    required this.step,
    required this.stepNumber,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: step.accentColor,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  '$stepNumber',
                  style: context.textStyles.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 80,
                margin: const EdgeInsets.symmetric(vertical: 4),
                color: step.accentColor.withValues(alpha: 0.3),
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Card(
            margin: const EdgeInsets.only(bottom: AppSpacing.md),
            child: Container(
              padding: AppSpacing.paddingMd,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border(
                  left: BorderSide(
                    color: step.accentColor,
                    width: 4,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.title,
                    style: context.textStyles.titleLarge?.copyWith(
                      color: step.accentColor,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    step.description,
                    style: context.textStyles.bodyMedium?.copyWith(
                      height: 1.5,
                    ),
                  ),
                  if (step.actionButton != null) ...[
                    const SizedBox(height: AppSpacing.md),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: Icon(
                          Icons.shopping_cart,
                          color: Theme.of(context).elevatedButtonTheme.style?.foregroundColor?.resolve({}),
                        ),
                        label: Text(step.actionButton!),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: step.accentColor,
                          foregroundColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
