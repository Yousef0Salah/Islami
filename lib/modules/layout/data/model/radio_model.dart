import 'dart:convert';

class ResponseRadio {
  final List<RadioModel> radios;

  ResponseRadio({required this.radios});

  factory ResponseRadio.fromJson(String str) =>
      ResponseRadio.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseRadio.fromMap(Map<String, dynamic> json) => ResponseRadio(
    radios: List<RadioModel>.from(
      json["radios"].map((x) => RadioModel.fromMap(x)),
    ),
  );

  Map<String, dynamic> toMap() => {
    "radios": List<dynamic>.from(radios.map((x) => x.toMap())),
  };
}

class RadioModel {
  final int id;
  final String name;
  final String url;
  final String recentDate;

  RadioModel({
    required this.id,
    required this.name,
    required this.url,
    required this.recentDate,
  });

  factory RadioModel.fromJson(String str) =>
      RadioModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory RadioModel.fromMap(Map<String, dynamic> json) => RadioModel(
    id: json["id"],
    name: json["name"],
    url: json["url"],
    recentDate: json["recent_date"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "url": url,
    "recent_date": recentDate,
  };
}
