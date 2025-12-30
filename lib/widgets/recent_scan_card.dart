import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kisanagi/models/disease_model.dart';
import 'package:kisanagi/theme.dart';

class RecentScanCard extends StatelessWidget {
  final DiseaseModel disease;

  const RecentScanCard({super.key, required this.disease});

  @override
  Widget build(BuildContext context) {
    final timeAgo = _getTimeAgo(disease.detectedAt);
    
    return Card(
      child: InkWell(
        onTap: () => context.push('/diagnosis/${disease.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: AppSpacing.paddingMd,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.asset(
                  disease.imageUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    width: 80,
                    height: 80,
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Icon(
                      Icons.bug_report,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      disease.name,
                      style: context.textStyles.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      disease.description,
                      style: context.textStyles.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      children: [
                        _SeverityChip(severity: disease.severity),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          timeAgo,
                          style: context.textStyles.bodySmall?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getTimeAgo(DateTime dateTime) {
    final difference = DateTime.now().difference(dateTime);
    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inMinutes}m ago';
    }
  }
}

class _SeverityChip extends StatelessWidget {
  final String severity;

  const _SeverityChip({required this.severity});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (severity.toLowerCase()) {
      case 'high':
        color = LightModeColors.accentRed;
        break;
      case 'medium':
        color = LightModeColors.lightSecondary;
        break;
      case 'low':
        color = LightModeColors.accentGreen;
        break;
      default:
        color = Theme.of(context).colorScheme.primary;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        severity.toUpperCase(),
        style: context.textStyles.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
