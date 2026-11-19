
import 'package:islami/modules/time/data/model/time_model.dart';

sealed class TimeState {
  
  
}
class TimeInitialState extends TimeState {}

class TimeLoadingState extends TimeState {}

class TimeSuccessState extends TimeState {}

class TimeErrorState extends TimeState {
  String message;
  TimeErrorState(this.message);
}

class TimeCountdownState extends TimeState {
  final AllSalah nextPrayer;
  final String remainingTime;

  TimeCountdownState({
    required this.nextPrayer,
    required this.remainingTime,
  });
}