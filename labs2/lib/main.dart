import 'package:flutter/material.dart';
import 'package:labs2/screens/details.dart';
import 'package:labs2/screens/home.dart';
import 'package:labs2/screens/meals.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meals App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Meals App'),
        "/meals": (context) => const MealsPage(),
        "/meals/details": (context) => const MealDetailsPage(),
      },
    );
  }
}
