import 'package:dio/dio.dart';
import 'package:islami/core/service/api.dart';

abstract class RemoteDataSource {
  Future<Response<dynamic>> getRadio();

  Future<Response<dynamic>> getReciters();

  Future<Response<dynamic>> getTime(String date);
}

class RemoteDataSourceImp implements RemoteDataSource {
  @override
  Future<Response<dynamic>> getRadio() {
    return ApiService().dio.get('radios?language=ar');
  }

  @override
  Future<Response<dynamic>> getReciters() {
    return ApiService().dio.get('reciters?language=ar');
  }

  @override
  Future<Response<dynamic>> getTime(String date) {
    return Dio(
      BaseOptions(baseUrl: 'https://api.aladhan.com/v1/timingsByCity/'),
    ).get('$date?city=cairo&country=egypt');
  }
}
