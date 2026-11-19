import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:islami/modules/time/data/model/azkar_model.dart';

Future<AzkarModel> getAzkar() async {
  final response = await rootBundle.loadString(
    'assets/azkar/azkar.json',
  );

  final Map<String, dynamic> data = jsonDecode(response);

  return AzkarModel.fromJson(data);
}