

import 'package:flutter/material.dart';
import 'package:labs2/models/meal_model.dart';

class MealCard extends StatelessWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, "/meals/details", arguments: { 'mealId': meal.id });
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.blue.shade600, width: 2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Column(
            children: [
              const SizedBox(height: 10),
              SizedBox(
                width: 100,
                height: 100,
                child: ClipOval(
                  child: Image.network(
                    meal.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    meal.name,
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
