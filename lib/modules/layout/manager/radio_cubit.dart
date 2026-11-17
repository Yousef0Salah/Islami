import 'package:bloc/bloc.dart';
import 'package:islami/modules/layout/data/model/radio_model.dart';
import 'package:islami/core/service/play_sound.dart';
import 'package:islami/modules/layout/data/model/reciters_model.dart';
import 'package:islami/modules/layout/data/model/time_model.dart';
import 'package:islami/modules/layout/data/repo/repo.dart';
import 'package:islami/modules/layout/manager/radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(RadioInitialState());

  Repo repo = RepoImp();

  //====================[ Reciter ]==============================

  int suraindex = 001;
  List<ReciterModel> reciterList = [];

  void getReciter() async {
    emit(RecitersLoadingState());
    try {
      if (reciterList.isNotEmpty) {
        return;
      }
      reciterList = await repo.getReciter();
      emit(RecitersSuccessState());
    } catch (e) {
      emit(RecitersErrorState(e.toString()));
    }
  }

  void skipNext() {
    if (suraindex < 114) {
      suraindex++;
    }
  }

  void skipPrevious() {
    if (suraindex > 1) {
      suraindex--;
    }
  }

  //====================[ Radio ]==============================
  List<RadioModel> radioList = [];

  void getRadio() async {
    emit(RadioLoadingState());
    try {
      if (radioList.isNotEmpty) {
        return;
      }
      radioList = await repo.getRadio();
      emit(RadioSuccessState());
    } catch (e) {
      emit(RadioErrorState(e.toString()));
    }
  }

  //---------------------------------

  final PlaySound playSound = PlaySound();

  bool isPlaying = false;
  bool isMute = false;
  String? currentRadioUrl;

  Future<void> playRadio(String url) async {
    try {
      if (currentRadioUrl == url && isPlaying) {
        await pauseRadio();
        return;
      }

      currentRadioUrl = url;

      await playSound.playSound(url);

      isPlaying = true;

      emit(RadioPlayerState(isPlaying: true, currentRadioUrl: currentRadioUrl));
    } catch (e) {
      print(e);
    }
  }

  Future<void> pauseRadio() async {
    await playSound.pauseSound();

    isPlaying = false;

    emit(RadioPlayerState(isPlaying: false, currentRadioUrl: currentRadioUrl));
  }

  Future<void> mute() async {
    await playSound.mute();

    isMute = true;

    emit(
      RadioPlayerState(isPlaying: isPlaying, currentRadioUrl: currentRadioUrl),
    );
  }

  Future<void> unmute() async {
    await playSound.unMute();

    isMute = false;

    emit(
      RadioPlayerState(isPlaying: isPlaying, currentRadioUrl: currentRadioUrl),
    );
  }

 
}
