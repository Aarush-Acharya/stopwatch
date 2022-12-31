import 'dart:async' as a;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'binding/ini.dart';
import 'package:stopwatch/controller/controller.dart';

void main() {
  IniBin().dependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: IniBin(),
      title: 'Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Timer'),
    );
  }
}

class MyHomePage extends MyApp {
  var x = 0;
  TextEditingController cont = TextEditingController();
  RegExp digitValidator = RegExp("^[0-9]+\$");
  final String title;
  MyHomePage({super.key, required this.title});
  var counter = Get.find<SwController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(
              () => SizedBox(
                width: 1180,
                child: TextField(
                  controller: cont,
                  textAlign: TextAlign.center,
                  onChanged: (inputValue) {
                    if (cont.text.isEmpty ||
                        digitValidator.hasMatch(cont.text)) {
                      counter.setValidator(true);
                    } else {
                      counter.setValidator(false);
                    }
                    ;
                    if (digitValidator.hasMatch(cont.text)) {
                      counter.setRunnable(true);
                    } else {
                      counter.setRunnable(false);
                    }
                  },
                  textInputAction: TextInputAction.go,
                  onSubmitted: (value) {
                    Get.snackbar('P r e s s  t h e  P l a y  B u t t o n',
                        'Press the Play Button to start the timer this is for your own caution',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.yellow);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    errorText: counter.isANumber.value
                        ? null
                        : "Please enter a number",
                    errorStyle: const TextStyle(color: Colors.blueGrey),
                    border: const OutlineInputBorder(),
                    labelText: 'Enter Stop Watch Time',
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => Text(
                counter.sw.value.toString(),
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(() => SizedBox(
                  child: counter.runin.value
                      ? Column(children: [
                          CircularProgressIndicator(
                            backgroundColor: Colors.white,
                            valueColor:
                                const AlwaysStoppedAnimation(Colors.blueAccent),
                            strokeWidth: 5,
                            value: (counter.sw.value / int.parse(cont.text)),
                            semanticsLabel: "Timer Covered",
                            semanticsValue:
                                ((counter.sw.value / int.parse(cont.text)) *
                                        100)
                                    .toString(),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          // ignore: prefer_interpolation_to_compose_strings
                          Text(((counter.sw.value / int.parse(cont.text)) * 100)
                                  .toString() +
                              "%")
                        ])
                      : null,
                ))

            // IconButton(icon: Icon(Icons.add),onPressed: counter.startSw(),)
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          counter.enabled.value
              ? counter.isANumber.value
                  ? counter.runnable.value
                      ? counter.runin.value
                          ? Get.snackbar(
                              'T i m e r   A l r e a d   R u n n i n g',
                              'Please wait for the previos timer to end',
                              snackPosition: SnackPosition.BOTTOM,
                              backgroundColor: Colors.yellow)
                          : a.Timer.periodic(
                              const Duration(seconds: 1),
                              // ignore: non_constant_identifier_names
                              (Timer) => {
                                    if (counter.sw.value >=
                                        int.parse(cont.text))
                                      {
                                        Timer.cancel(),
                                        Get.snackbar(
                                            'T i m e r   C o m p l e t e',
                                            'Congratulations! your timer is complete You can now set a new one',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.cyan),
                                        counter.sw.value = 0,
                                        counter.runin.value = false,
                                        // ignore: unnecessary_new
                                        a.Timer.periodic(
                                            const Duration(milliseconds: 500),
                                            // ignore: non_constant_identifier_names
                                            (Timer) => {
                                                  if(x >= 3){
                                                    x = 0,
                                                    Timer.cancel(),
                                                    }
                                                    else{
                                                      counter.player.setUrl(
                                                          'http://codeskulptor-demos.commondatastorage.googleapis.com/GalaxyInvaders/pause.wav'),
                                                      counter.player.play(),
                                                      x++
                                                    }
                                                }),
                                         x = 0
                                      }
                                    else
                                      {
                                        counter.enabled.value = false,
                                        counter.runin.value = true,
                                        counter.startSw(),
                                        // ignore: prefer_const_constructors
                                        a.Timer(Duration(microseconds: 200),
                                            () => counter.enabled.value = true),
                                      }
                                  })
                      : Get.snackbar('S e t  T i m e r  V a l u e',
                          'Please set a timer value before starting the timer',
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.red)
                  : Get.snackbar(
                      'I n v a l i d   I n p u t', 'Please Input a Number',
                      colorText: Colors.white,
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red)
                      : null;
        },
        tooltip: 'Start Timer',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
