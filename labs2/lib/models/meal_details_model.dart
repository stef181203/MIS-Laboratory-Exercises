class MealDetails {
  int id;
  String name;
  String image;
  String instructions;
  List<String> ingredients = List.empty();
  String youtubeLink;

  MealDetails({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    required this.youtubeLink,
  });

  factory MealDetails.fromJson(Map<String, dynamic> data) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final String ingredient = data['strIngredient$i'];
      if (ingredient.isEmpty) {
        break;
      }
      ingredients.add(ingredient);
    }

    return MealDetails(
      id: int.parse(data['idMeal']),
      name: data['strMeal'] ?? '',
      image: data['strMealThumb'] ?? '',
      instructions: data['strInstructions'] ?? '',
      ingredients: ingredients,
      youtubeLink: data['strYoutube'] ?? '',
    );
  }
}