import 'package:flutter/material.dart';
import '../../models/category_model.dart';
import 'category_card.dart';

class CategoryGrid extends StatefulWidget {
  final List<Category> categories;

  const CategoryGrid({super.key, required this.categories});

  @override
  State<StatefulWidget> createState() => _CategoryGridState();
}

class _CategoryGridState extends State<CategoryGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 200/210
      ),
      itemCount: widget.categories.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return CategoryCard(category: widget.categories[index]);
      },
    );
  }
}
