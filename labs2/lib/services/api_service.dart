import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:labs2/models/meal_details_model.dart';
import 'package:labs2/models/meal_model.dart';
import '../models/category_model.dart';

class ApiService {
  Future<List<Category>> loadCategoryList() async {
    List<Category> categoryList = [];

    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php'),
    );

    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      List<dynamic> categoriesJson = detailData["categories"];

      categoryList = categoriesJson
          .map((item) => Category.fromJson(item))
          .toList();
    }

    return categoryList;
  }

  Future<List<Meal>> loadMealsList(String category) async {
    List<Meal> mealsList = [];

    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'),
    );

    if (detailResponse.statusCode == 200) {
      final detailData = json.decode(detailResponse.body);
      List<dynamic> mealsJson = detailData["meals"];

      mealsList = mealsJson
          .map((item) => Meal.fromJson(item))
          .toList();
    }

    return mealsList;
  }

  Future<MealDetails?> loadMealDetails(int mealId) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$mealId'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['meals'] != null && data['meals'].isNotEmpty) {
          return MealDetails.fromJson(data['meals'][0]);
        }
      }
      return null;
    } catch (e) {
      return null;
    }
  }

}