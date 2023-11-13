import 'dart:convert';

Student studentFromJson(String str) => Student.fromJson(json.decode(str));

String studentToJson(Student data) => json.encode(data.toJson());

class Student {
  String? id;
  String title;
  String description;

  Student({
    this.id,
    required this.title,
    required this.description,
  });

  String toJson() => json.encode(toMap());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["id"],
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toMap() => {
        // "id": id,
        "title": title,
        "description": description,
      };
}
