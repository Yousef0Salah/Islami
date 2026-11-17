import 'dart:convert';

class ResponseReciters {
  final List<ReciterModel> reciters;

  ResponseReciters({required this.reciters});

  factory ResponseReciters.fromJson(String str) =>
      ResponseReciters.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ResponseReciters.fromMap(Map<String, dynamic> json) =>
      ResponseReciters(
        reciters: List<ReciterModel>.from(
          json["reciters"].map((x) => ReciterModel.fromMap(x)),
        ),
      );

  Map<String, dynamic> toMap() => {
    "reciters": List<dynamic>.from(reciters.map((x) => x.toMap())),
  };
}

class ReciterModel {
  final int id;
  final String name;
  final String letter;
  final DateTime date;
  final List<Moshaf> moshaf;

  ReciterModel({
    required this.id,
    required this.name,
    required this.letter,
    required this.date,
    required this.moshaf,
  });

  factory ReciterModel.fromJson(String str) =>
      ReciterModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ReciterModel.fromMap(Map<String, dynamic> json) => ReciterModel(
    id: json["id"],
    name: json["name"],
    letter: json["letter"],
    date: DateTime.parse(json["date"]),
    moshaf: List<Moshaf>.from(json["moshaf"].map((x) => Moshaf.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "letter": letter,
    "date": date.toIso8601String(),
    "moshaf": List<dynamic>.from(moshaf.map((x) => x.toMap())),
  };
}

class Moshaf {
  final int id;
  final String name;
  final int rewayaId;
  final String server;
  final int surahTotal;
  final int moshafType;
  final String surahList;

  Moshaf({
    required this.id,
    required this.name,
    required this.rewayaId,
    required this.server,
    required this.surahTotal,
    required this.moshafType,
    required this.surahList,
  });

  factory Moshaf.fromJson(String str) => Moshaf.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Moshaf.fromMap(Map<String, dynamic> json) => Moshaf(
    id: json["id"],
    name: json["name"],
    rewayaId: json["rewaya_id"],
    server: json["server"],
    surahTotal: json["surah_total"],
    moshafType: json["moshaf_type"],
    surahList: json["surah_list"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "rewaya_id": rewayaId,
    "server": server,
    "surah_total": surahTotal,
    "moshaf_type": moshafType,
    "surah_list": surahList,
  };
}
