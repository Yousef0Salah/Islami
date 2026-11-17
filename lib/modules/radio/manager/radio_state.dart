sealed class RadioState {}

class RadioLoadingState extends RadioState {}

class RadioInitialState extends RadioState {}

class RadioSuccessState extends RadioState {}

class RadioErrorState extends RadioState {
    String message;
  RadioErrorState(this.message);
}

class RadioPlayerState extends RadioState {
  final bool isPlaying;
  final String? currentRadioUrl;
  RadioPlayerState({required this.isPlaying, this.currentRadioUrl});
}

class RecitersInitialState extends RadioState {}

class RecitersLoadingState extends RadioState {}

class RecitersSuccessState extends RadioState {}

class RecitersErrorState extends RadioState {
  String message;
  RecitersErrorState(this.message);
}

class RadioTabChangedState extends RadioState{}