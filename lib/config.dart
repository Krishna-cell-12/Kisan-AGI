class Config {
  // Use `flutter run --dart-define=API_BASE_URL=https://example.com` to override.
  // For Android emulator use: http://10.0.2.2:5000
  static const String baseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://10.0.2.2:5000',
  );
}
