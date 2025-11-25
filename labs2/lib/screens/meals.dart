import 'package:flutter/material.dart';
import '../models/meal_model.dart';
import '../services/api_service.dart';
import '../widgets/meal/meal_grid.dart';

class MealsPage extends StatefulWidget {
  const MealsPage({super.key});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  late final List<Meal> _meals;
  bool _isLoading = true;
  late final String _categoryName;
  bool _loaded = false;
  final ApiService _apiService = ApiService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (!_loaded) {
      _categoryName = ModalRoute.of(context)!.settings.arguments as String;
      _loadMealsList();
      _loaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_categoryName),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: _meals.isEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Meal found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: MealGrid(meals: _meals),
            ),
          ),
        ],
      ),
    );
  }

  void _loadMealsList() async {
    final mealsList = await _apiService.loadMealsList(_categoryName);

    setState(() {
      _meals = mealsList;
      _isLoading = false;
    });
  }
}

