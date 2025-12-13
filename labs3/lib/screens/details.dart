import 'package:flutter/material.dart';
import '../models/meal_details_model.dart';
import '../services/api_service.dart';

class MealDetailsPage extends StatefulWidget {
  const MealDetailsPage({super.key});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  String _title = 'Details';
  MealDetails? _meal;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    if(args?['title'] != null) {
      _title = args?['title'];
    }

    if(_title == 'Random Meal') {
      _loadRandomMealDetails();
    }
    else {
      _loadMealDetails();
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _meal == null
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.search_off, size: 64, color: Colors.grey),
            SizedBox(height: 16),
            Text(
              'No Meal details found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ],
        ),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              height: 350,
              child: Material(
                elevation: 5,
                borderRadius: BorderRadius.circular(20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    _meal!.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10,),
            _mealDetailsTable(_meal!),
          ],
        ),
      ),
    );
  }

  void _loadMealDetails() async {
    final args = ModalRoute.of(context)!.settings.arguments as Map?;
    final mealId = args?['mealId'] as int;
    final mealDetails = await _apiService.loadMealDetails(mealId);

    if (!mounted) return;
    setState(() {
      _meal = mealDetails;
      _isLoading = false;
    });
  }

  void _loadRandomMealDetails() async {
    final mealDetails = await _apiService.loadRandomMealDetails();

    if (!mounted) return;
    setState(() {
      _meal = mealDetails;
      _isLoading = false;
    });
  }
}

Widget _mealDetailsTable(MealDetails meal) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Table(
      border: TableBorder.all(color: Colors.grey),
      columnWidths: const {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Meal Name', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(meal.name),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Instructions', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(meal.instructions),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Ingredients', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(meal.ingredients.join(', ')),
            ),
          ],
        ),
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('YouTube Link', style: TextStyle(fontWeight: FontWeight.bold),),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(meal.youtubeLink),
            ),
          ],
        ),
      ],
    ),
  );
}

