import 'package:flutter/material.dart';
import 'package:labs3/models/meal_model.dart';
import '../../services/favorites_service.dart';

class MealCard extends StatefulWidget {
  final Meal meal;

  const MealCard({super.key, required this.meal});

  @override
  State<MealCard> createState() => _MealCardState();
}

class _MealCardState extends State<MealCard> {
  final favoritesService = FavoritesService.instance;

  @override
  Widget build(BuildContext context) {
    final isFav = favoritesService.isFavorite(widget.meal);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          "/meals/details",
          arguments: {'mealId': widget.meal.id},
        );
      },
      child: Stack(
        children: [
          Card(
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
                        widget.meal.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        widget.meal.name,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 4,
            right: 4,
            child: IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  favoritesService.toggleFavorite(widget.meal);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}
