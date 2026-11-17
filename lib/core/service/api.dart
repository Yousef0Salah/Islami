import 'package:dio/dio.dart';

final dio = Dio();

class ApiService {
   Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://www.mp3quran.net/api/v3/",
     
    ),
  );
}