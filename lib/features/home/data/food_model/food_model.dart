class FoodModel {
  String? id;
  String? name;
  String? category;
  int? calories;
  dynamic createdBy;
  int? v;

  FoodModel({
    this.id,
    this.name,
    this.category,
    this.calories,
    this.createdBy,
    this.v,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        category: json['category'] as String?,
        calories: json['calories'] as int?,
        createdBy: json['createdBy'] as dynamic,
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'category': category,
        'calories': calories,
        'createdBy': createdBy,
        '__v': v,
      };
}
