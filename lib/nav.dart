import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kisanagi/screens/language_selection_screen.dart';
import 'package:kisanagi/screens/phone_login_screen.dart';
import 'package:kisanagi/screens/dashboard_screen.dart';
import 'package:kisanagi/screens/scan_screen.dart';
import 'package:kisanagi/screens/diagnosis_screen.dart';
import 'package:kisanagi/screens/community_screen.dart';
import 'package:kisanagi/screens/profile_screen.dart';
import 'package:kisanagi/screens/settings_screen.dart';
import 'package:kisanagi/screens/notifications_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.language,
    routes: [
      GoRoute(
        path: AppRoutes.language,
        name: 'language',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const LanguageSelectionScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const PhoneLoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        pageBuilder: (context, state) => NoTransitionPage(
          child: const DashboardScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.scan,
        name: 'scan',
        pageBuilder: (context, state) => MaterialPage(
          child: const ScanScreen(),
        ),
      ),
      GoRoute(
        path: '${AppRoutes.diagnosis}/:id',
        name: 'diagnosis',
        pageBuilder: (context, state) {
          final diseaseId = state.pathParameters['id']!;
          return MaterialPage(
            child: DiagnosisScreen(diseaseId: diseaseId),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.community,
        name: 'community',
        pageBuilder: (context, state) => MaterialPage(
          child: const CommunityScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        name: 'profile',
        pageBuilder: (context, state) => MaterialPage(
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.settings,
        name: 'settings',
        pageBuilder: (context, state) => MaterialPage(child: const SettingsScreen()),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        name: 'notifications',
        pageBuilder: (context, state) => MaterialPage(child: const NotificationsScreen()),
      ),
    ],
  );
}

class AppRoutes {
  static const String language = '/language';
  static const String login = '/login';
  static const String home = '/';
  static const String scan = '/scan';
  static const String diagnosis = '/diagnosis';
  static const String community = '/community';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
}
