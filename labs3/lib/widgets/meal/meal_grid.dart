import 'package:flutter/material.dart';
import 'package:labs3/models/meal_model.dart';
import 'meal_card.dart';

class MealGrid extends StatefulWidget {
  final List<Meal> meals;

  const MealGrid({super.key, required this.meals});

  @override
  State<StatefulWidget> createState() => _MealGridState();
}

class _MealGridState extends State<MealGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 200/210,
      ),
      itemCount: widget.meals.length,
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return MealCard(meal: widget.meals[index]);
      },
    );
  }
}
