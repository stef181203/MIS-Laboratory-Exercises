import 'package:flutter/material.dart';
import 'package:labs1/screens/details.dart';
import 'package:labs1/screens/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Распоред за испити - 221187",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
      ),
      initialRoute: "/",
      routes: {
        "/": (context) => const MyHomePage(title: 'Распоред за испити - 221187'),
        "/details": (context) => const DetailsPage(),
      },
    );
  }
}