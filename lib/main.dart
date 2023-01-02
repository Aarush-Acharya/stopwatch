import 'dart:async';
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
  work() {
    counter.runin.value = true;
    Timer.periodic(
        const Duration(seconds: 1),
        // ignore: non_constant_identifier_names
        (timer) => {
              if (counter.sw.value >= int.parse(cont.text))
                {
                  timer.cancel(),
                  Get.snackbar('T i m e r   C o m p l e t e',
                      'Congratulations! your timer is complete You can now set a new one',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.cyan),
                  counter.sw.value = 0,
                  counter.runin.value = false,
                  // ignore: unnecessary_new
                  Timer.periodic(
                      const Duration(milliseconds: 500),
                      // ignore: non_constant_identifier_names
                      (timer2) => {
                            if (x >= 3)
                              {
                                x = 0,
                                timer2.cancel(),
                              }
                            else
                              {
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
                  counter.startSw(),
                }
            });
  }

  check() {
    print("runno");
  }

  retnull() {
    null;
  }

  var x = 0;
  TextEditingController cont = TextEditingController();
  RegExp digitValidator = RegExp("^[0-9]+\$");
  final String title;
  MyHomePage({super.key, required this.title});
  var counter = Get.find<SwController>();
  var timer_string = "";

  GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();

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
            SizedBox(
              width: 1180,
              child: TextFormField(
                key: _formKey,
                controller: cont,
                textAlign: TextAlign.center,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => value!.isEmpty
                    ? null
                    : digitValidator.hasMatch(value)
                        ? null
                        : "Please enter a number",
                textInputAction: TextInputAction.go,
                onFieldSubmitted: (value) {
                  if (_formKey.currentState?.validate() != true) return;
                  Get.snackbar('P r e s s  t h e  P l a y  B u t t o n',
                      'Press the Play Button to start the timer this is for your own caution',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.yellow);
                  timer_string = value;
                },
                onChanged: (value) {
                    if (_formKey.currentState?.validate() != true) return;
                    timer_string = value;
                },
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  // errorText: counter.isANumber.value
                  //     ? null
                  //     : "Please enter a number",
                  // errorStyle: const TextStyle(color: Colors.blueGrey),
                  border: OutlineInputBorder(),
                  labelText: 'Enter Stop Watch Time',
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
          if (timer_string.isEmpty) return counter.get2();

          // ignore: void_checks
          if (counter.runin.value) return counter.get1();
          // ignore: void_checks
          if (_formKey.currentState?.validate() != true) return counter.get3();
          work();
        },
        tooltip: 'Start Timer',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
