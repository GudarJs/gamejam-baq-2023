import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame_audio/flame_audio.dart';

class MusicTracks extends FlameGame {
  static void introMusic(double volume) {
    FlameAudio.loopLongAudio('intro_music.mp3', volume: volume);
  }

  static void pauseMusic(double volume) {
    FlameAudio.loopLongAudio('pause_music.mp3', volume: volume);
  }
}
