import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SwController extends GetxController {
  var sw = 0.obs;
  var isANumber = true.obs;
  var runin = false.obs;
  var runnable = false.obs;
  var enabled = true.obs;
  late AudioPlayer player = AudioPlayer();
  startSw() {
    sw.value++;
  }

  setRunnable(bool y) {
    runnable.value = y;
  }

  setValidator(bool x) {
    isANumber.value = x;
  }
}
