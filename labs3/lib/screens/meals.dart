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
  List<Meal> _filteredMeals = [];
  bool _isLoading = true;
  late final String _categoryName;
  bool _loaded = false;
  final ApiService _apiService = ApiService();
  bool _isSearching = false;
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

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
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search Meal by name...',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                ),
                TextButton(
                  onPressed: _isSearching
                      ? null
                      : () async {
                    await _searchMealByName(_searchQuery);
                  },
                  child: _isSearching
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                      : const Text('Search'),
                ),

              ],
            ),

          ),
          Expanded(
            child: _filteredMeals.isEmpty && _searchQuery.isNotEmpty
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
              child: MealGrid(meals: _filteredMeals),
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
      _filteredMeals = mealsList;
      _isLoading = false;
    });
  }

  Future<void> _searchMealByName(String name) async {
    if (name.isEmpty) return;

    setState(() {
      _isSearching = true;
    });

    final meal = await _apiService.searchMealByName(name);

    setState(() {
      _isSearching = false;
      if (meal != null && meal.category == _categoryName) {
        _filteredMeals = [meal];
      } else {
        _filteredMeals = [];
      }
    });
  }

}

