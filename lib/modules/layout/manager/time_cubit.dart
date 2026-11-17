import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:islami/modules/layout/data/model/time_model.dart';
import 'package:islami/modules/layout/data/repo/repo.dart';
import 'package:islami/modules/layout/manager/time_state.dart';

class TimeCubit extends Cubit<TimeState> {
  TimeCubit() : super(TimeInitialState());

  //=========================Time=================

  TimeData? time;
  AllData? allData;

  Repo repo = RepoImp();

  Future<void> getTime() async {
    emit(TimeLoadingState());
    try {
      time = await repo.getTime();
      allData = AllData.getAllData(time!);
      if (isClosed) return;
      emit(TimeSuccessState());
    } catch (e) {
      if (isClosed) return;
      emit(TimeErrorState(e.toString()));
    }
  }
}
