import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:kisanagi/services/user_service.dart';
import 'package:kisanagi/theme.dart';

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: SafeArea(
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Icon(
                Icons.language,
                size: 80,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                'Welcome to Kisan-AGI',
                style: context.textStyles.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Select your preferred language',
                style: context.textStyles.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              LanguageCard(
                language: 'English',
                nativeText: 'English',
                languageCode: 'en',
                icon: '🇬🇧',
                onTap: () => _selectLanguage(context, 'en'),
              ),
              const SizedBox(height: AppSpacing.md),
              LanguageCard(
                language: 'Hindi',
                nativeText: 'हिंदी',
                languageCode: 'hi',
                icon: '🇮🇳',
                onTap: () => _selectLanguage(context, 'hi'),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }

  void _selectLanguage(BuildContext context, String languageCode) async {
    await context.read<UserService>().setLanguage(languageCode);
    if (context.mounted) {
      context.go('/login');
    }
  }
}

class LanguageCard extends StatelessWidget {
  final String language;
  final String nativeText;
  final String languageCode;
  final String icon;
  final VoidCallback onTap;

  const LanguageCard({
    super.key,
    required this.language,
    required this.nativeText,
    required this.languageCode,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: AppSpacing.paddingLg,
          child: Row(
            children: [
              Text(
                icon,
                style: const TextStyle(fontSize: 48),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      language,
                      style: context.textStyles.titleLarge,
                    ),
                    Text(
                      nativeText,
                      style: context.textStyles.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
