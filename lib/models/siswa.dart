class Siswa {
  final int id;
  final String name;
  final int noAbsen;
  final int classId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Class siswaClass;

  Siswa({
    required this.id,
    required this.name,
    required this.noAbsen,
    required this.classId,
    required this.createdAt,
    required this.updatedAt,
    required this.siswaClass,
  });

  factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        id: json["id"],
        name: json["name"],
        noAbsen: json["no_absen"],
        classId: json["class_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        siswaClass: Class.fromJson(json["class"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "no_absen": noAbsen,
        "class_id": classId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "class": siswaClass.toJson(),
      };
}

class Class {
  final int id;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Class({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Class.fromJson(Map<String, dynamic> json) => Class(
        id: json["id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
