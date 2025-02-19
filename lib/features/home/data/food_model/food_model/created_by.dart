class CreatedBy {
  String? id;
  String? name;
  String? email;

  CreatedBy({this.id, this.name, this.email});

  factory CreatedBy.fromJson(Map<String, dynamic> json) => CreatedBy(
        id: json['_id'] as String?,
        name: json['name'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'email': email,
      };
}
