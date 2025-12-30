import 'package:flutter/material.dart';
import 'package:kisanagi/theme.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: AppSpacing.paddingLg,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withValues(alpha: 0.8),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Today\'s Weather',
                      style: context.textStyles.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '28',
                          style: context.textStyles.displayLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 52,
                          ),
                        ),
                        Text(
                          '°C',
                          style: context.textStyles.headlineMedium?.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Icon(
                  Icons.wb_sunny,
                  size: 80,
                  color: LightModeColors.lightSecondary,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            Divider(color: Colors.white.withValues(alpha: 0.3)),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _WeatherDetail(
                  icon: Icons.water_drop,
                  label: 'Humidity',
                  value: '65%',
                ),
                _WeatherDetail(
                  icon: Icons.air,
                  label: 'Wind',
                  value: '12 km/h',
                ),
                _WeatherDetail(
                  icon: Icons.visibility,
                  label: 'Visibility',
                  value: '8 km',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _WeatherDetail extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _WeatherDetail({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white.withValues(alpha: 0.9),
          size: 24,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: context.textStyles.bodySmall?.copyWith(
            color: Colors.white.withValues(alpha: 0.8),
          ),
        ),
        Text(
          value,
          style: context.textStyles.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
