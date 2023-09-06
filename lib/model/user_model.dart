import 'dart:convert';

class User {
  int? age;
  String? description;
  List<String>? images;
  int? likeCount;
  String? location;
  String? name;
  List<String>? tags;

  User({
    this.age,
    this.description,
    this.images,
    this.likeCount,
    this.location,
    this.name,
    this.tags,
  });

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<Object?, Object?> json) => User(
        age: json["age"] as int?,
        description: json["description"] as String,
        images: json["images"] == null
            ? []
            : List<String>.from((json["images"] as List).map((x) => x)),
        likeCount: json["likeCount"] as int?,
        location: json["location"] as String?,
        name: json["name"] as String?,
        tags: json["tags"] == null
            ? []
            : List<String>.from((json["tags"] as List).map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "age": age,
        "description": description,
        "images":
            images == null ? [] : List<dynamic>.from(images!.map((x) => x)),
        "likeCount": likeCount,
        "location": location,
        "name": name,
        "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
      };
}
