
sealed class TimeState {
  
  
}
class TimeInitialState extends TimeState {}

class TimeLoadingState extends TimeState {}

class TimeSuccessState extends TimeState {}

class TimeErrorState extends TimeState {
  String message;
  TimeErrorState(this.message);
}
