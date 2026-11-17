import 'package:dio/dio.dart';
import 'package:islami/core/service/api.dart';

abstract class RemoteDataSource {
  Future<Response<dynamic>> getRadio();

  Future<Response<dynamic>> getReciters();

  Future<Response<dynamic>> getTime();
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
  Future<Response<dynamic>> getTime() {
    return Dio(
      BaseOptions(baseUrl: 'https://api.aladhan.com/v1/timingsByCity/'),
    ).get('15-11-2026?city=cairo&country=egypt');
  }
}
