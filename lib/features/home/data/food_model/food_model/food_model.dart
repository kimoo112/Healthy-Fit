import 'created_by.dart';

class FoodModel {
  String? id;
  String? name;
  String? category;
  int? calories;
  int? protein;
  int? carbohydrate;
  CreatedBy? createdBy;
  int? v;

  FoodModel({
    this.id,
    this.name,
    this.category,
    this.calories,
    this.protein,
    this.carbohydrate,
    this.createdBy,
    this.v,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        category: json['category'] as String?,
        calories: json['calories'] as int?,
        protein: json['protein'] as int?,
        carbohydrate: json['carbohydrate'] as int?,
        createdBy: json['createdBy'] == null
            ? null
            : CreatedBy.fromJson(json['createdBy'] as Map<String, dynamic>),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'category': category,
        'calories': calories,
        'protein': protein,
        'carbohydrate': carbohydrate,
        'createdBy': createdBy?.toJson(),
        '__v': v,
      };
}
