import 'dart:convert';

import 'package:islami/modules/data/model/radio_model.dart';
import 'package:islami/modules/data/data_source/remote_data_source.dart';
import 'package:islami/modules/data/model/reciters_model.dart';
import 'package:islami/modules/time/data/model/time_model.dart';

abstract class Repo {
  Future<List<RadioModel>> getRadio();

  Future<List<ReciterModel>> getReciter();

  Future<TimeData> getTime(String timeNow);
}

class RepoImp implements Repo {
  RemoteDataSource remoteDataSource = RemoteDataSourceImp();
  @override
  Future<List<RadioModel>> getRadio() async {
    try {
      var response = await remoteDataSource.getRadio();
      var data = ResponseRadio.fromJson(response.toString());
      return data.radios;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

  @override
  Future<List<ReciterModel>> getReciter() async {
    try {
      var response = await remoteDataSource.getReciters();
      var data = ResponseReciters.fromJson(response.toString());
      return data.reciters;
    } catch (e) {
      print(e.toString());
      rethrow;
    }
  }

 @override
  Future<TimeData> getTime( String timeNow) async {
  try {
    final response = await remoteDataSource.getTime(timeNow);
    final data = ResponseTime.fromJson(
      response.toString(),
    );
    if (data.code == 200 ) {
      return data.data!;
    }
    throw Exception(data.status);
  } catch (e) {
    print('getTime error: $e');
    rethrow;
  }
}
}
