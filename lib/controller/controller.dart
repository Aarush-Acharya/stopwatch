import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';

class SwController extends GetxController {
  var sw = 0.obs;
  var runin = false.obs;
  late AudioPlayer player = AudioPlayer();
  startSw() {
    sw.value++;
  }

  get1() {
    Get.snackbar('T i m e r   A l r e a d   R u n n i n g',
        'Please wait for the previos timer to end',
        snackPosition: SnackPosition.BOTTOM, backgroundColor: Colors.yellow);
  }

  get2() {
    Get.snackbar('S e t  T i m e r  V a l u e',
        'Please set a timer value before starting the timer',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red);
  }

  get3() {
    Get.snackbar('I n v a l i d   I n p u t', 'Please Input a Number',
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red);
  }
}
