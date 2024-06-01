// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_callkit_incoming/entities/call_kit_params.dart';
import 'package:flutter_callkit_incoming/entities/ios_params.dart';
import 'package:flutter_callkit_incoming/flutter_callkit_incoming.dart';
import 'package:generease/app/ui/widget/button.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class CallingScreen extends StatefulWidget {
  const CallingScreen({super.key});

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  final Map<String, dynamic> arguments = Get.arguments;

  Timer? timer;
  Duration myDuration = const Duration(minutes: 3);
  late final Uuid _uuid;
  String? _currentUuid;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setCountDown();
    });
  }

  void stopTimer() {
    setState(() {
      timer?.cancel();
    });
  }

  void setCountDown() {
    int reduceSecondsBy = 1;
    setState(() {
      var seconds = myDuration.inSeconds - reduceSecondsBy;
      if (seconds < 0) {
        timer?.cancel();
        Get.back();
      } else {
        myDuration = Duration(seconds: seconds);
      }
    });
  }

  Future<void> startOutGoingCall() async {
    _currentUuid = _uuid.v4();
    final params = CallKitParams(
      id: _currentUuid,
      nameCaller: 'Hien Nguyen',
      handle: '0123456789',
      type: 1,
      extra: <String, dynamic>{'userId': '1a2b3c4d'},
      ios: const IOSParams(handleType: 'number'),
    );
    await FlutterCallkitIncoming.startCall(params);
  }

  @override
  void initState() {
    super.initState();
    // startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String strDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = strDigits(myDuration.inMinutes.remainder(60));
    final seconds = strDigits(myDuration.inSeconds.remainder(60));

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: Get.width,
          height: Get.height,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  const CustomBackButton(),
                  const Spacer(),
                  const Text(
                    '00:00',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  // Text(
                  //   '$minutes:$seconds',
                  //   style: const TextStyle(
                  //       fontSize: 16, fontWeight: FontWeight.w700,),
                  // ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                arguments['name'],
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                '전화 연결 대기 중입니다...',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Stack(
                children: [
                  Container(
                    width: 245,
                    height: 245,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.black,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(120),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: Image.asset(
                        'assets/images/person.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    width: 245,
                    height: 245,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(120),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 80,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      spreadRadius: 0.1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: const Color(0xffEE5050),
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => const CallingScreen(),
                        arguments: {'name': '조나희', 'phoneNum': '01031090060'},
                      );
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 288,
                      height: 76,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            '통화종료',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Image.asset(
                            'assets/icons/call_end.png',
                            width: 50,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      spreadRadius: 0.1,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Material(
                  color: const Color(0xff595959),
                  borderRadius: BorderRadius.circular(6),
                  child: InkWell(
                    onTap: () {
                      Get.to(
                        () => const CallingScreen(),
                        arguments: {'name': '조나희', 'phoneNum': '01031090060'},
                      );
                    },
                    borderRadius: BorderRadius.circular(6),
                    child: Container(
                      width: 288,
                      height: 76,
                      // padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            '음소거',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Image.asset(
                            'assets/icons/unmute.png',
                            width: 57,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
