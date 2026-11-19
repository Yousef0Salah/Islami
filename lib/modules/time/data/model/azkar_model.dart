

class AzkarModel {
  final List<Zekr> morningAzkar;
  final List<Zekr> eveningAzkar;

  const AzkarModel({ required this.morningAzkar, required this.eveningAzkar});

  factory AzkarModel.fromJson(Map<String, dynamic> data) {
  return AzkarModel(
    morningAzkar: parseAzkar(data['أذكار الصباح']),
    eveningAzkar: parseAzkar(data['أذكار المساء']),
  );

}
}

class Zekr {
  final String category;
  final int count;
  final String description;
  final String reference;
  final String content;

  const Zekr({
    required this.category,
    required this.count,
    required this.description,
    required this.reference,
    required this.content,
  });

  factory Zekr.fromJson(Map<String, dynamic> data) {
    return Zekr(
      category: data['category'] ?? '',
      count: int.tryParse(data['count'].toString()) ?? 1,
      description: data['description'] ?? '',
      reference: data['reference'] ?? '',
      content: data['content'] ?? '',
    );
  }
}



List<Zekr> parseAzkar(dynamic data) {
  return (data as List)
      .expand((item) => item is List ? item : [item])
      .where((item) => item is Map && item['category'] != 'stop')
      .map((item) => Zekr.fromJson(
            Map<String, dynamic>.from(item),
          ))
      .toList();
}