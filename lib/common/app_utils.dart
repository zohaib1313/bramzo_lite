import 'package:audioplayers/audioplayers.dart';

class AppUtils {
  static void playTapSound() {
    print("playsound");
    AudioPlayer()
        .play(AssetSource("sounds/tap.mp3"), mode: PlayerMode.lowLatency);
  }
}
