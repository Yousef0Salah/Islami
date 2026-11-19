import 'dart:convert';

/// Shared JSON serialization for API models.
mixin JsonModel {
  Map<String, dynamic> toMap();

  String toJson() => json.encode(toMap());
}

class ResponseTime with JsonModel {
  final int code;
  final String status;
  final TimeData? data;

  const ResponseTime({required this.code, required this.status, this.data});

  factory ResponseTime.fromJson(String str) =>
      ResponseTime.fromMap(json.decode(str) as Map<String, dynamic>);

  factory ResponseTime.fromMap(Map<String, dynamic> json) => ResponseTime(
    code: _asInt(json["code"]) ?? 0,
    status: _asString(json["status"]) ?? 'Unknown',
    data: json["data"] is Map<String, dynamic>
        ? TimeData.fromMap(json["data"] as Map<String, dynamic>)
        : null,
  );

  Map<String, dynamic> toMap() => {
    "code": code,
    "status": status,
    "data": data?.toMap(),
  };
}

class TimeData with JsonModel {
  final Timings timings;
  final PrayerDate date;
  final Meta meta;

  const TimeData({
    required this.timings,
    required this.date,
    required this.meta,
  });

  factory TimeData.fromJson(String str) =>
      TimeData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory TimeData.fromMap(Map<String, dynamic> json) => TimeData(
    timings: Timings.fromMap(
      _asMap(json["timings"]) ?? const <String, dynamic>{},
    ),
    date: PrayerDate.fromMap(_asMap(json["date"]) ?? const <String, dynamic>{}),
    meta: Meta.fromMap(_asMap(json["meta"]) ?? const <String, dynamic>{}),
  );

  Map<String, dynamic> toMap() => {
    "timings": timings.toMap(),
    "date": date.toMap(),
    "meta": meta.toMap(),
  };
}

class Timings with JsonModel {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String sunset;
  final String maghrib;
  final String isha;
  final String imsak;
  final String midnight;
  final String firstthird;
  final String lastthird;

  const Timings({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.sunset,
    required this.maghrib,
    required this.isha,
    required this.imsak,
    required this.midnight,
    required this.firstthird,
    required this.lastthird,
  });

  factory Timings.fromJson(String str) =>
      Timings.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Timings.fromMap(Map<String, dynamic> json) => Timings(
    fajr: _asString(json["Fajr"]) ?? '--:--',
    sunrise: _asString(json["Sunrise"]) ?? '--:--',
    dhuhr: _asString(json["Dhuhr"]) ?? '--:--',
    asr: _asString(json["Asr"]) ?? '--:--',
    sunset: _asString(json["Sunset"]) ?? '--:--',
    maghrib: _asString(json["Maghrib"]) ?? '--:--',
    isha: _asString(json["Isha"]) ?? '--:--',
    imsak: _asString(json["Imsak"]) ?? '--:--',
    midnight: _asString(json["Midnight"]) ?? '--:--',
    firstthird: _asString(json["Firstthird"]) ?? '--:--',
    lastthird: _asString(json["Lastthird"]) ?? '--:--',
  );

  Map<String, dynamic> toMap() => {
    "Fajr": fajr,
    "Sunrise": sunrise,
    "Dhuhr": dhuhr,
    "Asr": asr,
    "Sunset": sunset,
    "Maghrib": maghrib,
    "Isha": isha,
    "Imsak": imsak,
    "Midnight": midnight,
    "Firstthird": firstthird,
    "Lastthird": lastthird,
  };

  // ---- Helper: قائمة الصلوات الخمس مرتبة ----
  /// يعيد خريطة [الاسم -> الوقت] للصلوات الخمس فقط.
  Map<String, String> get fivePrayers => {
    'FAJR': fajr,
    'DHUHR': dhuhr,
    'ASR': asr,
    'MAGHRIB': maghrib,
    'ISHA': isha,
  };

  /// يعيد الوقت بصيغة 12 ساعة + AM/PM.
  static ({String time, String period}) to12h(String raw) {
    final clean = raw.replaceAll(RegExp(r'\s*\(.*\)'), '').trim();
    final parts = clean.split(':');
    if (parts.length != 2) return (time: raw, period: '');

    final h24 = int.tryParse(parts[0]);
    final m = int.tryParse(parts[1]);

    // لو مش أرقام، ارجع القيمة الأصلية
    if (h24 == null || m == null) return (time: raw, period: '');

    final period = h24 >= 12 ? 'PM' : 'AM';
    final h12 = (h24 % 12 == 0) ? 12 : h24 % 12;
    return (
      time: '${h12.toString().padLeft(2, '0')}:${m.toString().padLeft(2, '0')}',
      period: period,
    );
  }
}

class PrayerDate with JsonModel {
  final String readable;
  final String timestamp;
  final Hijri hijri;
  final Gregorian gregorian;

  const PrayerDate({
    required this.readable,
    required this.timestamp,
    required this.hijri,
    required this.gregorian,
  });

  factory PrayerDate.fromJson(String str) =>
      PrayerDate.fromMap(json.decode(str) as Map<String, dynamic>);

  factory PrayerDate.fromMap(Map<String, dynamic> json) => PrayerDate(
    readable: _asString(json["readable"]) ?? '',
    timestamp: _asString(json["timestamp"]) ?? '',
    hijri: Hijri.fromMap(_asMap(json["hijri"]) ?? const <String, dynamic>{}),
    gregorian: Gregorian.fromMap(
      _asMap(json["gregorian"]) ?? const <String, dynamic>{},
    ),
  );

  Map<String, dynamic> toMap() => {
    "readable": readable,
    "timestamp": timestamp,
    "hijri": hijri.toMap(),
    "gregorian": gregorian.toMap(),
  };
}

class Gregorian with JsonModel {
  final String date;
  final String format;
  final String day;
  final GregorianWeekday weekday;
  final GregorianMonth month;
  final String year;
  final Designation designation;
  final bool lunarSighting;

  const Gregorian({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.lunarSighting,
  });

  factory Gregorian.fromJson(String str) =>
      Gregorian.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Gregorian.fromMap(Map<String, dynamic> json) => Gregorian(
    date: _asString(json["date"]) ?? '',
    format: _asString(json["format"]) ?? '',
    day: _asString(json["day"]) ?? '',
    weekday: GregorianWeekday.fromMap(
      _asMap(json["weekday"]) ?? const <String, dynamic>{},
    ),
    month: GregorianMonth.fromMap(
      _asMap(json["month"]) ?? const <String, dynamic>{},
    ),
    year: _asString(json["year"]) ?? '',
    designation: Designation.fromMap(
      _asMap(json["designation"]) ?? const <String, dynamic>{},
    ),
    lunarSighting: json["lunarSighting"] == true,
  );

  Map<String, dynamic> toMap() => {
    "date": date,
    "format": format,
    "day": day,
    "weekday": weekday.toMap(),
    "month": month.toMap(),
    "year": year,
    "designation": designation.toMap(),
    "lunarSighting": lunarSighting,
  };
}

class Designation with JsonModel {
  final String abbreviated;
  final String expanded;

  const Designation({required this.abbreviated, required this.expanded});

  factory Designation.fromJson(String str) =>
      Designation.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Designation.fromMap(Map<String, dynamic> json) => Designation(
    abbreviated: _asString(json["abbreviated"]) ?? '',
    expanded: _asString(json["expanded"]) ?? '',
  );

  Map<String, dynamic> toMap() => {
    "abbreviated": abbreviated,
    "expanded": expanded,
  };
}

class GregorianMonth with JsonModel {
  final int number;
  final String en;

  const GregorianMonth({required this.number, required this.en});

  factory GregorianMonth.fromJson(String str) =>
      GregorianMonth.fromMap(json.decode(str) as Map<String, dynamic>);

  factory GregorianMonth.fromMap(Map<String, dynamic> json) => GregorianMonth(
    number: _asInt(json["number"]) ?? 0,
    en: _asString(json["en"]) ?? '',
  );

  Map<String, dynamic> toMap() => {"number": number, "en": en};

  /// اختصار آمن للشهر (3 أحرف).
  String get shortEn => en.length >= 3 ? en.substring(0, 3) : en;
}

class GregorianWeekday with JsonModel {
  final String en;

  const GregorianWeekday({required this.en});

  factory GregorianWeekday.fromJson(String str) =>
      GregorianWeekday.fromMap(json.decode(str) as Map<String, dynamic>);

  factory GregorianWeekday.fromMap(Map<String, dynamic> json) =>
      GregorianWeekday(en: _asString(json["en"]) ?? '');

  Map<String, dynamic> toMap() => {"en": en};
}

class Hijri with JsonModel {
  final String date;
  final String format;
  final String day;
  final HijriWeekday weekday;
  final HijriMonth month;
  final String year;
  final Designation designation;
  final List<String> holidays;
  final List<dynamic> adjustedHolidays;
  final String method;

  const Hijri({
    required this.date,
    required this.format,
    required this.day,
    required this.weekday,
    required this.month,
    required this.year,
    required this.designation,
    required this.holidays,
    required this.adjustedHolidays,
    required this.method,
  });

  factory Hijri.fromJson(String str) =>
      Hijri.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Hijri.fromMap(Map<String, dynamic> json) => Hijri(
    date: _asString(json["date"]) ?? '',
    format: _asString(json["format"]) ?? '',
    day: _asString(json["day"]) ?? '',
    weekday: HijriWeekday.fromMap(
      _asMap(json["weekday"]) ?? const <String, dynamic>{},
    ),
    month: HijriMonth.fromMap(
      _asMap(json["month"]) ?? const <String, dynamic>{},
    ),
    year: _asString(json["year"]) ?? '',
    designation: Designation.fromMap(
      _asMap(json["designation"]) ?? const <String, dynamic>{},
    ),
    holidays: (json["holidays"] as List?)?.cast<String>() ?? const [],
    adjustedHolidays:
        (json["adjustedHolidays"] as List?)?.cast<dynamic>() ?? const [],
    method: _asString(json["method"]) ?? '',
  );

  Map<String, dynamic> toMap() => {
    "date": date,
    "format": format,
    "day": day,
    "weekday": weekday.toMap(),
    "month": month.toMap(),
    "year": year,
    "designation": designation.toMap(),
    "holidays": List<dynamic>.from(holidays),
    "adjustedHolidays": List<dynamic>.from(adjustedHolidays),
    "method": method,
  };
}

class HijriMonth with JsonModel {
  final int number;
  final String en;
  final String ar;
  final int days;

  const HijriMonth({
    required this.number,
    required this.en,
    required this.ar,
    required this.days,
  });

  factory HijriMonth.fromJson(String str) =>
      HijriMonth.fromMap(json.decode(str) as Map<String, dynamic>);

  factory HijriMonth.fromMap(Map<String, dynamic> json) => HijriMonth(
    number: _asInt(json["number"]) ?? 0,
    en: _asString(json["en"]) ?? '',
    ar: _asString(json["ar"]) ?? '',
    days: _asInt(json["days"]) ?? 0,
  );

  Map<String, dynamic> toMap() => {
    "number": number,
    "en": en,
    "ar": ar,
    "days": days,
  };

  /// Safe month abbreviation (3 characters).
  String get shortEn => en.length >= 3 ? en.substring(0, 3) : en;
}

class HijriWeekday with JsonModel {
  final String en;
  final String ar;

  const HijriWeekday({required this.en, required this.ar});

  factory HijriWeekday.fromJson(String str) =>
      HijriWeekday.fromMap(json.decode(str) as Map<String, dynamic>);

  factory HijriWeekday.fromMap(Map<String, dynamic> json) => HijriWeekday(
    en: _asString(json["en"]) ?? '',
    ar: _asString(json["ar"]) ?? '',
  );

  Map<String, dynamic> toMap() => {"en": en, "ar": ar};
}

class Meta with JsonModel {
  final double latitude;
  final double longitude;
  final String timezone;
  final Method method;
  final String latitudeAdjustmentMethod;
  final String midnightMode;
  final String school;
  final Map<String, int> offset;

  const Meta({
    required this.latitude,
    required this.longitude,
    required this.timezone,
    required this.method,
    required this.latitudeAdjustmentMethod,
    required this.midnightMode,
    required this.school,
    required this.offset,
  });

  factory Meta.fromJson(String str) =>
      Meta.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    latitude: _asDouble(json["latitude"]) ?? 0.0,
    longitude: _asDouble(json["longitude"]) ?? 0.0,
    timezone: _asString(json["timezone"]) ?? '',
    method: Method.fromMap(_asMap(json["method"]) ?? const <String, dynamic>{}),
    latitudeAdjustmentMethod: _asString(json["latitudeAdjustmentMethod"]) ?? '',
    midnightMode: _asString(json["midnightMode"]) ?? '',
    school: _asString(json["school"]) ?? '',
    offset: (_asMap(json["offset"]) ?? const {}).map(
      (k, v) => MapEntry(k, _asInt(v) ?? 0),
    ),
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
    "timezone": timezone,
    "method": method.toMap(),
    "latitudeAdjustmentMethod": latitudeAdjustmentMethod,
    "midnightMode": midnightMode,
    "school": school,
    "offset": Map<String, dynamic>.from(offset),
  };
}

class Method with JsonModel {
  final int id;
  final String name;
  final Params params;
  final Location location;

  const Method({
    required this.id,
    required this.name,
    required this.params,
    required this.location,
  });

  factory Method.fromJson(String str) =>
      Method.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Method.fromMap(Map<String, dynamic> json) => Method(
    id: _asInt(json["id"]) ?? 0,
    name: _asString(json["name"]) ?? '',
    params: Params.fromMap(_asMap(json["params"]) ?? const <String, dynamic>{}),
    location: Location.fromMap(
      _asMap(json["location"]) ?? const <String, dynamic>{},
    ),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "params": params.toMap(),
    "location": location.toMap(),
  };
}

class Location with JsonModel {
  final double latitude;
  final double longitude;

  const Location({required this.latitude, required this.longitude});

  factory Location.fromJson(String str) =>
      Location.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Location.fromMap(Map<String, dynamic> json) => Location(
    latitude: _asDouble(json["latitude"]) ?? 0.0,
    longitude: _asDouble(json["longitude"]) ?? 0.0,
  );

  Map<String, dynamic> toMap() => {
    "latitude": latitude,
    "longitude": longitude,
  };
}

class Params with JsonModel {
  final double fajr;
  final double isha;

  const Params({required this.fajr, required this.isha});

  factory Params.fromJson(String str) =>
      Params.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Params.fromMap(Map<String, dynamic> json) => Params(
    fajr: _asDouble(json["Fajr"]) ?? 0.0,
    isha: _asDouble(json["Isha"]) ?? 0.0,
  );

  Map<String, dynamic> toMap() => {"Fajr": fajr, "Isha": isha};
}

String? _asString(dynamic v) {
  if (v == null) return null;
  if (v is String) return v;
  return v.toString();
}

int? _asInt(dynamic v) {
  if (v == null) return null;
  if (v is int) return v;
  if (v is num) return v.toInt();
  return int.tryParse(v.toString());
}

double? _asDouble(dynamic v) {
  if (v == null) return null;
  if (v is double) return v;
  if (v is num) return v.toDouble();
  return double.tryParse(v.toString());
}

Map<String, dynamic>? _asMap(dynamic v) {
  if (v is Map<String, dynamic>) return v;
  if (v is Map) {
    return v.map((k, val) => MapEntry(k.toString(), val));
  }
  return null;
}

//============really use in app===============
class AllData {
  final String hijri;
  final String greg;
  final String weekday;
  final List<AllSalah> listSalah;

  const AllData({
    required this.hijri,
    required this.greg,
    required this.weekday,
    required this.listSalah,
  });

  static AllData getAllData(TimeData data) {
    final gregDate = data.date.gregorian;
    final hijriDate = data.date.hijri;

    return AllData(
      hijri: '${hijriDate.day} ${hijriDate.month.shortEn}\n${hijriDate.year}',
      greg: '${gregDate.day} ${gregDate.month.shortEn}\n${gregDate.year}',
      weekday: gregDate.weekday.en,
      listSalah: AllSalah.getAllSalah(data.timings.fivePrayers),
    );
  }
}

class AllSalah {
  final String name;
  final String time;
  final String pmAm;
  final String rawTime;

  const AllSalah({
    required this.name,
    required this.time,
    required this.pmAm,
    required this.rawTime,
  });

  static List<AllSalah> getAllSalah(Map<String, String> salah) {
    return salah.entries.map((e) {
      final t = Timings.to12h(e.value);
      return AllSalah(
        name: e.key,
        time: t.time,
        pmAm: t.period,
        rawTime: e.value,
      );
    }).toList();
  }
}
