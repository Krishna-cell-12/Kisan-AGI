import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:kisanagi/services/user_service.dart';
import 'package:kisanagi/services/crop_service.dart';
import 'package:kisanagi/services/disease_service.dart';
import 'package:kisanagi/services/post_service.dart';
import 'theme.dart';
import 'nav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserService()..initialize()),
        ChangeNotifierProvider(create: (_) => CropService()..initialize()),
        ChangeNotifierProvider(create: (_) => DiseaseService()..initialize()),
        ChangeNotifierProvider(create: (_) => PostService()..initialize()),
      ],
      child: MaterialApp.router(
        title: 'Kisan-AGI',
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        darkTheme: darkTheme,
        themeMode: ThemeMode.light,
        routerConfig: AppRouter.router,
      ),
    );
  }
}
