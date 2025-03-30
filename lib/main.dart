import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_genie/firebase_options.dart';
import 'package:pocket_genie/presentation/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';

// Example usage in main.dart
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Genie',
      theme: ThemeData(
        primaryColor: const Color(0xFFFFB347), // Gold Amber
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFFB347),
          secondary: const Color(0xFF946CDE), // Magic Purple
        ),
        scaffoldBackgroundColor: const Color(0xFFF9F9F9),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Color(0xFF333333),
          elevation: 0,
        ),
      ),
      home: const HomeScreen(),
    );
  }
}
