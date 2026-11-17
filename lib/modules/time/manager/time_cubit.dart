import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/modules/data/model/time_model.dart';
import 'package:islami/modules/data/repo/repo.dart';
import 'package:islami/modules/time/manager/time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitialState());

  //=========================Time=================

  TimeData? time;
  AllData allData = AllData(hijri: '', greg: '', weekday: '', listSalah: []);

  Repo repo = RepoImp();

  Future<void> getTime({bool forceRefresh = false}) async {
    if (!forceRefresh && allData.listSalah.isNotEmpty) return;

    emit(TimeLoadingState());
    try {
      time = await repo.getTime();
      if (isClosed) return;
      allData = AllData.getAllData(time!);
      emit(TimeSuccessState());
    } catch (e) {
      if (isClosed) return;
      emit(TimeErrorState(e.toString()));
    }
  }
}
