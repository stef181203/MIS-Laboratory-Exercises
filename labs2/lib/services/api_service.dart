import 'dart:convert';
import 'package:http/http.dart' as http;
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
}