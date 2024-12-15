import 'package:flutter/material.dart';
import 'pages/welcome_page.dart';
import 'pages/categories_page.dart';
import 'pages/meals_page.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/categories': (context) => const CategoriesPage(),
        '/meals': (context) => const MealsPage(),
      },
    );
  }
}