import 'package:flutter/material.dart';
import 'package:kisanagi/models/crop_model.dart';
import 'package:kisanagi/theme.dart';

class CropCard extends StatelessWidget {
  final CropModel crop;

  const CropCard({super.key, required this.crop});

  @override
  Widget build(BuildContext context) {
    final daysAgo = DateTime.now().difference(crop.plantedDate).inDays;
    
    return SizedBox(
      width: 140,
      child: Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 3,
              child: Image.asset(
                crop.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  child: Icon(
                    Icons.eco,
                    size: 48,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: AppSpacing.paddingSm,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      crop.name,
                      style: context.textStyles.titleMedium,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Icon(
                          crop.status == 'healthy' ? Icons.check_circle : Icons.warning,
                          size: 12,
                          color: crop.status == 'healthy'
                              ? LightModeColors.accentGreen
                              : LightModeColors.accentRed,
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            '$daysAgo days ago',
                            style: context.textStyles.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
