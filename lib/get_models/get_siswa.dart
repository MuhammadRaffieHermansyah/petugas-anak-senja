import 'package:tes/models/siswa.dart';

class GetSiswa {
  final List<Siswa> data;

  GetSiswa({
    required this.data,
  });

  factory GetSiswa.fromJson(Map<String, dynamic> json) => GetSiswa(
        data: List<Siswa>.from(json["data"].map((x) => Siswa.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}
