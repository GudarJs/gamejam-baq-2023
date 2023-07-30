import 'package:flame_audio/flame_audio.dart';

class SoundEffects extends FlameAudio {
  static void introDialog() {
    FlameAudio.play('intro_dialog.mp3');
  }

  static void touchMenu() {
    FlameAudio.play('play_2.mp3');
  }

  static void play() {
    FlameAudio.play('touch_menu.mp3');
  }

  static void pause() {
    FlameAudio.play('pause.mp3');
  }

  static void fallDown() {
    FlameAudio.play('fall_down.mp3');
  }

  static void jump() {
    FlameAudio.play('jump.mp3');
  }

  static void slide() {
    FlameAudio.play('slide.mp3');
  }

  static void gameOver() {
    FlameAudio.play('game_over.mp3');
  }

  static void correctItem() {
    FlameAudio.play('correct_item.mp3');
  }
}
