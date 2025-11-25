class Meal {
  int id;
  String name;
  String image;

  Meal({
    required this.id,
    required this.name,
    required this.image
  });

  Meal.fromJson(Map<String, dynamic> data)
      : id = int.parse(data['idMeal']),
        name = data['strMeal'],
        image = data['strMealThumb'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'image': image
  };
}