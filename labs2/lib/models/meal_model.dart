class Meal {
  int id;
  String name;
  String image;
  String? category;

  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.category,
  });

  Meal.fromJson(Map<String, dynamic> data)
      : id = int.parse(data['idMeal']),
        name = data['strMeal'],
        image = data['strMealThumb'],
        category = data['strCategory'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image,
    'category': category,
  };
}