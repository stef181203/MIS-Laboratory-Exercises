import 'package:flutter/material.dart';
import 'package:labs3/screens/details.dart';
import 'package:labs3/screens/home.dart';
import 'package:labs3/screens/meals.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
