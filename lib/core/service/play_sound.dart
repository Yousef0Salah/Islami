import 'package:audioplayers/audioplayers.dart';

class PlaySound {
  final AudioPlayer player = AudioPlayer();

  Future<void> playSound(String path) async {
    await player.stop();
    await player.play(UrlSource(path));
  }

  Future<void> pauseSound() async {
    await player.pause();
  }

  Future<void> resumeSound() async {
    await player.resume();
  }

  Future<void> stopSound() async {
    await player.stop();
  }

  Future<void> mute() async {
    await player.setVolume(0);
  }

  Future<void> unMute() async {
    await player.setVolume(1);
  }

  void dispose() {
    player.dispose();
  }
}
