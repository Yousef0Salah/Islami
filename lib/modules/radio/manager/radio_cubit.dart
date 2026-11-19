import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:islami/modules/data/model/radio_model.dart';
import 'package:islami/core/service/play_sound.dart';
import 'package:islami/modules/data/model/reciters_model.dart';
import 'package:islami/modules/time/data/model/time_model.dart';
import 'package:islami/modules/data/repo/repo.dart';
import 'package:islami/modules/radio/manager/radio_state.dart';

class RadioCubit extends Cubit<RadioState> {
  RadioCubit() : super(RadioInitialState());

  Repo repo = RepoImp();

  bool isRadio = true;

  void changeTab(bool value) {
    if (isRadio == value) return;

    isRadio = value;

    if (isRadio) {
      getRadio();
    } else {
      getReciter();
    }
  }

  //====================[ Reciter ]==============================

  int suraIndex = 001;
  List<ReciterModel> reciterList = [];

  Future<void> getReciter() async {
    if (reciterList.isNotEmpty) {
      emit(RecitersSuccessState());
      return;
    }
    emit(RecitersLoadingState());
    try {
      reciterList = await repo.getReciter();
      emit(RecitersSuccessState());
    } catch (e) {
      emit(RecitersErrorState(e.toString()));
    }
  }

  void skipNext() {
    if (suraIndex < 114) {
      suraIndex++;
    }
  }

  void skipPrevious() {
    if (suraIndex > 1) {
      suraIndex--;
    }
  }

  //====================[ Radio ]==============================
  List<RadioModel> radioList = [];

  Future<void> getRadio() async {
    if (radioList.isNotEmpty) {
      emit(RadioSuccessState());
      return;
    }
    emit(RadioLoadingState());
    try {
      radioList = await repo.getRadio();
      emit(RadioSuccessState());
    } catch (e) {
      emit(RadioErrorState(e.toString()));
    }
  }

  //=====================play sound==========

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

      await playSound.playSound(url);
      currentRadioUrl = url;
      isPlaying = true;
      _emitPlayerState();
    } catch (e) {
      debugPrint('Play Radio Error: $e');
    }
  }

  Future<void> pauseRadio() async {
    try {
      await playSound.pauseSound();

      isPlaying = false;

      _emitPlayerState();
    } catch (e) {
      debugPrint('Pause Radio Error: $e');
    }
  }

  Future<void> mute() async {
    if (isMute) return;
    await playSound.mute();

    isMute = true;

    _emitPlayerState();
  }

  Future<void> unmute() async {
    if (!isMute) return;
    await playSound.unMute();

    isMute = false;

    _emitPlayerState();
  }

  //-----------------play state---------------
  void _emitPlayerState() {
    emit(
      RadioPlayerState(isPlaying: isPlaying, currentRadioUrl: currentRadioUrl),
    );
  }
}
