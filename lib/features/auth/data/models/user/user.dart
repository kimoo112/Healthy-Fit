class LoginResponseModel {
  String? token;
  User? user;

  LoginResponseModel({this.token, this.user});

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) =>
      LoginResponseModel(
        token: json['token'] as String?,
        user: json['user'] == null
            ? null
            : User.fromJson(json['user'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'user': user?.toJson(),
      };
}

class User {
  String? id;
  String? name;
  String? email;
  String? password;
  int? height;
  int? weight;
  int? age;
  int? calorieGoal;
  String? preferredUnit;
  List<dynamic>? favorites;
  int? v;

  User({
    this.id,
    this.name,
    this.email,
    this.password,
    this.height,
    this.weight,
    this.age,
    this.calorieGoal,
    this.preferredUnit,
    this.favorites,
    this.v,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
        password: json['password'] as String?,
        height: json['height'] as int?,
        weight: json['weight'] as int?,
        age: json['age'] as int?,
        calorieGoal: json['calorieGoal'] as int?,
        preferredUnit: json['preferredUnit'] as String?,
        favorites: json['favorites'] == null
            ? []
            : List<dynamic>.from(json['favorites']),
        v: json['__v'] as int?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
        'password': password,
        'height': height,
        'weight': weight,
        'age': age,
        'calorieGoal': calorieGoal,
        'preferredUnit': preferredUnit,
        'favorites': favorites,
        '__v': v,
      };
}
